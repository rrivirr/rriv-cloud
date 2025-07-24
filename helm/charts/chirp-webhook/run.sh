 echo "Starting the application..."
            npm install -g express
            npm install -g pg
            cd `npm root -g`
            pwd
            node <<EOF

              function decode_naive(data){
                let dataDecoded = Buffer.from(data, 'base64')
                console.log('dataDecoded', dataDecoded);

                let values = {};

                // decode from naive codec
                const timestamp = dataDecoded.readBigUInt64BE(0);
                values['timestamp'] = timestamp
                console.log(timestamp);
                let j = 1;
                for( i = 8; i < 20; i = i + 4) {
                  const value = dataDecoded.readInt32BE(i) / 100;
                  values['value_'+j] = value;
                  j = j + 1;
                }
                
                const json = JSON.stringify(values);
                return json;  
              }

              function insert(body){

                const { time, deviceInfo: { devEui }, data } = body;

                console.log('time', time, 'devEui', devEui, 'data', data);

                const dataDecoded = Buffer.from(data, 'base64').toString('utf8');
                console.log('dataDecoded', dataDecoded);

                const pg = require('pg');

                const client = new pg.Client({
                  user: 'tsdbadmin',
                  host: 'lwevgo6wge.cd63s5urs1.tsdb.cloud.timescale.com',
                  database: 'tsdb',
                  password: process.env.TIMESCALE_DATABASE_PASSWORD,
                  port: 37881,
                  ssl: true,
                });

                const sql = "INSERT INTO events (time, eui, data ) VALUES ( '" +
                  time + 
                  "', '" + 
                  devEui + 
                  "', '" + 
                  dataDecoded + 
                  "')";
                console.log('sql:', sql);

                return client.connect()
                  .then(() => {
                    return client.query(sql);
                  })
                  .then(res => {
                    console.log('res:', res);
                    return client.end();
                  })
                  .catch(e => {
                    console.error(e);
                    throw e;
                  });

              }


              function insert_things(body){

                const { received_at, end_device_ids: { dev_eui }, uplink_message : {frm_payload} } = body;

                const time = received_at;
                const data = frm_payload;
                const devEui = dev_eui;
                console.log('time', time, 'devEui', devEui, 'data', data);

                let dataDecoded = Buffer.from(data, 'base64')
                console.log('dataDecoded', dataDecoded);

                let values = {};

                // decode from naive codec
                const timestamp = dataDecoded.readBigUInt64BE(0);
                values['timestamp'] = timestamp
                console.log(timestamp);
                let j = 1;
                for( i = 8; i < 20; i = i + 4) {
                  const value = dataDecoded.readInt32BE(i) / 100;
                  values['value_'+j] = value;
                  j = j + 1;
                }
                
                const json = JSON.stringify(values);

                const pg = require('pg');

                const client = new pg.Client({
                  user: 'tsdbadmin',
                  host: 'lwevgo6wge.cd63s5urs1.tsdb.cloud.timescale.com',
                  database: 'tsdb',
                  password: process.env.TIMESCALE_DATABASE_PASSWORD,
                  port: 37881,
                  ssl: true,
                });

                const sql = "INSERT INTO events (time, eui, data, values ) VALUES ( '" +
                  time + 
                  "', '" + 
                  devEui + 
                  "', '" + 
                  data + 
                  "', '" + 
                  json + 
                  "')";
                console.log('sql:', sql);

                return client.connect()
                  .then(() => {
                    return client.query(sql);
                  })
                  .then(res => {
                    console.log('res:', res);
                    return client.end();
                  })
                  .catch(e => {
                    console.error(e);
                    throw e;
                  });

              }


              const express = require('express');
              const app = express();
              app.use(express.json());
              app.use(express.urlencoded({ extended: true }));

              // Define a route for the root URL
              app.get('/', (req, res) => {
                  res.send('Hi from RRIV!');
              });

              app.post('/rriv-web-hook', (req, res) => {
                console.log('body', req.body);
                insert(req.body)
                  .then(() => {
                    res.send('ok');
                  })
                  .catch(e => {
                    console.error(e);
                    res.status(500).send('error');
                  });
              });

              app.post('/rriv-web-hook-things-stack', (req, res) => {
                console.log('body', req.body);
                insert_things(req.body)
                  .then(() => {
                    res.send('ok');
                  })
                  .catch(e => {
                    console.error(e);
                    res.status(500).send('error');
                  });
              });

              // Start the server
              app.listen(80, () => {
                  console.log('running...');
              });
EOF

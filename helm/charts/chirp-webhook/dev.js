
// const buffer = new Buffer('506BF1E3506BF1E3506BF1E3','hex');
const buffer = Buffer.from('AAAAADhv+voAAwGIAAAAAAAAAAAAAA==', 'base64');
let dataDecoded = buffer;
console.log(buffer.length);
console.log('dataDecoded', dataDecoded);

// get timestamp
const timestamp = dataDecoded.readBigUInt64BE(0);
console.log(timestamp);
for( i = 8; i < 20; i = i + 4) {
    const value = dataDecoded.readInt32BE(i) / 100;
    console.log(value);
}

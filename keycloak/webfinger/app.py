from flask import Flask, request, jsonify

app = Flask(__name__)

REALM_ISSUER = "https://auth.rriv.org/realms/rriv-internal"
DOMAIN = "rriv.org"

@app.route("/.well-known/webfinger")
def webfinger():
    resource = request.args.get("resource")
    
    if not resource or not resource.startswith("acct:") or f"@{DOMAIN}" not in resource:
        return "Invalid resource", 400

    return jsonify({
        "subject": resource,
        "links": [
            {
                "rel": "http://openid.net/specs/connect/1.0/issuer",
                "href": REALM_ISSUER
            }
        ]
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)

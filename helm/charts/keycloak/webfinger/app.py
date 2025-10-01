import os
from flask import Flask, request, jsonify

app = Flask(__name__)
env = os.getenv("ENV", "dev")

if env in ("dev", "staging"):
    REALM_ISSUER = f"https://auth.{env}.rriv.org/realms/rriv-beta-{env}"
else:
    REALM_ISSUER = "https://auth.rriv.org/realms/rriv-beta-prod"
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
    # This i
    # s only used for local development
    # In production, use: gunicorn -w 4 -b 0.0.0.0:8080 app:app
    app.run(host="0.0.0.0", port=8080, debug=False)

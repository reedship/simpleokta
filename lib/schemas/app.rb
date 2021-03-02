{
  "id": "0oaud6YvvS7AghVmH0g3",
  "name": "testorg_testsamlapp_1",
  "label": "Test SAML App",
  "status": "ACTIVE",
  "lastUpdated": "2016-06-29T16:13:47.000Z",
  "created": "2016-06-29T16:13:47.000Z",
  "accessibility": {
    "selfService": false,
    "errorRedirectUrl": null,
    "loginRedirectUrl": null
  },
  "visibility": {
    "autoSubmitToolbar": false,
    "hide": {
      "iOS": false,
      "web": false
    },
    "appLinks": {
      "testorgone_testsamlapp_1_link": true
    }
  },
  "features": [],
  "request_object_signing_alg":"RS256",
  "signOnMode": "SAML_2_0",
  "credentials": {
    "userNameTemplate": {
      "template": "${source.login}",
      "type": "BUILT_IN"
    },
    "signing": {}
  },
  "settings": {
    "app": {},
    "notifications": {
      "vpn": {
        "network": {
          "connection": "ANYWHERE"
        },
        "message": "Help message text.",
        "helpUrl": "http://www.help-site.example.com/"
      }
    },
    "signOn": {
      "defaultRelayState": "",
      "ssoAcsUrl": "https://www.example.com/sso/saml",
      "idpIssuer": "http://www.okta.com/${org.externalKey}",
      "audience": "https://www.example.com/",
      "recipient": "https://www.example.com/sso/saml",
      "destination": "https://www.example.com/sso/saml",
      "subjectNameIdTemplate": "${user.userName}",
      "subjectNameIdFormat": "urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified",
      "responseSigned": true,
      "assertionSigned": true,
      "signatureAlgorithm": "RSA_SHA256",
      "digestAlgorithm": "SHA256",
      "honorForceAuthn": true,
      "authnContextClassRef": "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport",
      "spIssuer": null,
      "requestCompressed": false,
      "allowMultipleAcsEndpoints": false,
      "acsEndpoints": [],
      "attributeStatements": []
    }
  },
  "_links": {
    "logo": [
      {
        "name": "medium",
        "href": "http://testorgone.okta.com/assets/img/logos/default.6770228fb0dab49a1695ef440a5279bb.png",
        "type": "image/png"
      }
    ],
    "appLinks": [
      {
        "name": "testorgone_testsamlapp_1_link",
        "href": "http://testorgone.okta.com/home/testorgone_testsamlapp_1/0oaud6YvvS7AghVmH0g3/alnun3sSjdvR9IYuy0g3",
        "type": "text/html"
      }
    ],
    "help": {
      "href": "http://testorgone-admin.okta.com:/app/testorgone_testsamlapp_1/0oaud6YvvS7AghVmH0g3/setup/help/SAML_2_0/instructions",
      "type": "text/html"
    },
    "users": {
      "href": "http://testorgone.okta.com/api/v1/apps/0oaud6YvvS7AghVmH0g3/users"
    },
    "deactivate": {
      "href": "http://testorgone.okta.com:/api/v1/apps/0oaud6YvvS7AghVmH0g3/lifecycle/deactivate"
    },
    "groups": {
      "href": "http://testorgone.okta.com/api/v1/apps/0oaud6YvvS7AghVmH0g3/groups"
    },
    "metadata": {
      "href": "http://testorgone.okta.com/api/v1/apps/0oaud6YvvS7AghVmH0g3/sso/saml/metadata",
      "type": "application/xml"
    }
  }
}

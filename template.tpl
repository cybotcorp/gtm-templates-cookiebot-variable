___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.
 
 ___INFO___

{
  "displayName": "Cookiebot Consent State",
  "description": "Use with the Cookiebot CMP Tag to signal the individual website user's consent state to tags that are setting cookies.",
  "categories": ["TAG_MANAGEMENT", "PERSONALIZATION"],
  "securityGroups": [],
  "id": "cvt_temp_public_id",
  "type": "MACRO",
  "version": 1,
  "containerContexts": [
    "WEB"
  ],
  "brand": {}
}


___TEMPLATE_PARAMETERS___

[]


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "CookieConsent"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const queryPermission = require('queryPermission');
const getCookieValues = require('getCookieValues');
const cookieName = 'CookieConsent';
let returnValue = '|';
let cookieValues;

if (queryPermission('get_cookies', cookieName)) {
  cookieValues = getCookieValues(cookieName);
  if (cookieValues && cookieValues.length > 0) {
  	let consentCookie = cookieValues[0].toLowerCase();
    if(consentCookie === "-1") //user is outside applicable jurisdiction > full consent
    {
      returnValue = '|preferences|statistics|marketing|'; 
    }
    else
    {
      if (consentCookie.indexOf('preferences:true') > -1)
      {
        returnValue += 'preferences|';
      }
      if (consentCookie.indexOf('statistics:true') > -1)
      {
        returnValue += 'statistics|';
      }
      if (consentCookie.indexOf('marketing:true') > -1)
      {
        returnValue += 'marketing|';
      }
    }
  }
}

return returnValue;


___NOTES___

Created on 19.8.2019 15.23.37

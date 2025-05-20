___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "DD Ketch CMP Consent State (Unofficial)",
  "description": "Use with the Ketch CMP to identify the individual website user\u0027s consent state and configure when tags should execute.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "ketchConsentStateCheckType",
    "displayName": "Select Consent State Check Type",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "ketchAllConsentState",
        "displayValue": "All Consent State Check"
      },
      {
        "value": "ketchSpecificConsentState",
        "displayValue": "Specific Consent State"
      }
    ],
    "simpleValueType": true,
    "help": "Select the type of consent state check you want to perform—either a specific consent category or all consent categories, based on Ketch."
  },
  {
    "type": "SELECT",
    "name": "ketchConsentCategoryCheckDrop",
    "displayName": "Select Ketch Consent Category",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "ketchsecurity_storage",
        "displayValue": "security_storage"
      },
      {
        "value": "ketchfunctionality_storage",
        "displayValue": "functionality_storage"
      },
      {
        "value": "ketchad_storage",
        "displayValue": "ad_storage"
      },
      {
        "value": "ketchpersonalization_storage",
        "displayValue": "personalization_storage"
      },
      {
        "value": "ketchsecurity_storage",
        "displayValue": "security_storage"
      },
      {
        "value": "ketchanalytics_storage",
        "displayValue": "analytics_storage"
      },
      {
        "value": "ketchad_user_data",
        "displayValue": "ad_user_data"
      },
      {
        "value": "ketchad_personalization",
        "displayValue": "ad_personalization"
      },
      {
        "value": "ketchdata_sharing",
        "displayValue": "data_sharing"
      },
      {
        "value": "ketchpersonalization",
        "displayValue": "personzation"
      },
      {
        "value": "ketchtargeted_advertising",
        "displayValue": "targeted_advertising"
      },
      {
        "value": "ketchcustom_consent_category",
        "displayValue": "custom consent category"
      }
    ],
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "ketchConsentStateCheckType",
        "paramValue": "ketchSpecificConsentState",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "ketchCustomConsentCat",
    "displayName": "Enter Consent Category",
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "ketchConsentCategoryCheckDrop",
        "paramValue": "ketchcustom_consent_category",
        "type": "EQUALS"
      }
    ],
    "help": "Enter the consent category value",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "valueHint": "e.g., persads"
  },
  {
    "type": "CHECKBOX",
    "name": "ketchEnableOptionalConfig",
    "checkboxText": "Enable Optional Output Transformation",
    "simpleValueType": true
  },
  {
    "type": "GROUP",
    "name": "ketchOptionalConfig",
    "displayName": "Ketch Consent State Value Transformation",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "SELECT",
        "name": "ketchTrue",
        "displayName": "Transform \"True\"",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "ketchTrueGranted",
            "displayValue": "granted"
          },
          {
            "value": "ketchTrueAccept",
            "displayValue": "accept"
          }
        ],
        "simpleValueType": true
      },
      {
        "type": "SELECT",
        "name": "ketchFalse",
        "displayName": "Transform \"False\"",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "ketchFalseDenied",
            "displayValue": "denied"
          },
          {
            "value": "ketchFalseDeny",
            "displayValue": "deny"
          }
        ],
        "simpleValueType": true
      },
      {
        "type": "CHECKBOX",
        "name": "ketchUndefined",
        "checkboxText": "Also transform \"undefined\" to \"denied\"",
        "simpleValueType": true
      }
    ],
    "enablingConditions": [
      {
        "paramName": "ketchEnableOptionalConfig",
        "paramValue": true,
        "type": "EQUALS"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const copyFromWindow = require('copyFromWindow');
const getType = require('getType');
const makeString = require('makeString');

const checkType = data.ketchConsentStateCheckType;
const categoryKey = data.ketchConsentCategoryCheckDrop;
const customCategory = data.ketchCustomConsentCat;
const enableTransform = data.ketchEnableOptionalConfig;
const transformTrue = data.ketchTrue;
const transformFalse = data.ketchFalse;
const transformUndefined = data.ketchUndefined;

function transformValue(val) {
  if (!enableTransform) return val;

  if (val === true) {
    return transformTrue === 'ketchTrueGranted' ? 'granted' : 'accept';
  }

  if (val === false) {
    return transformFalse === 'ketchFalseDenied' ? 'denied' : 'deny';
  }

  if (getType(val) === 'undefined' && transformUndefined) {
    return transformValue(false);
  }

  return val;
}

function getConsentData() {
  return copyFromWindow('ketchConsent');
}

const consentData = getConsentData();
if (getType(consentData) !== 'object') return undefined;

if (checkType === 'ketchAllConsentState') {
  const result = {};
  const keys = [
    'security_storage',
    'functionality_storage',
    'ad_storage',
    'personalization_storage',
    'analytics_storage',
    'ad_user_data',
    'ad_personalization',
    'data_sharing',
    'personalization',
    'targeted_advertising'
  ];

  keys.forEach(function (key) {
    const value = getType(consentData[key]) !== 'undefined' ? consentData[key] : (transformUndefined ? false : undefined);
    result[key] = transformValue(value);
  });

  return result;

} else if (checkType === 'ketchSpecificConsentState') {
  let rawKey = makeString(categoryKey).replace('ketch', '');

  if (rawKey === 'custom_consent_category') {
    rawKey = makeString(customCategory);
  }

  if (!rawKey) return undefined;

  const value = getType(consentData[rawKey]) !== 'undefined' ? consentData[rawKey] : (transformUndefined ? false : undefined);
  return transformValue(value);
}

return undefined;


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ketchConsent"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
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


___TESTS___

scenarios: []


___NOTES___

Created on 5/20/2025, 9:58:07 AM



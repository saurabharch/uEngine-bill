 uEngine Bill


<a name="overview"></a>
# Overview
유엔진 빌링은 과금 및 결제 오픈소스 플랫폼입니다.


## Version information
*Version* : 1.0


## Contact information
*Contact* : sppark@uengine.org, +821040341807, Seungpil Park, 유엔진 솔루션즈


## License information
*License* : Apache License, Version 2.0  
*License URL* : http://www.apache.org/licenses/LICENSE-2.0.html  
*Terms of service* : null


## Tags

* accounts
* auth
* bundles
* credits
* customFields
* invoicePayments
* invoices
* notification
* onetimebuy
* organization
* overdue
* paymentMethods
* paymentTransactions
* payments
* product
* retry
* rule
* subscriptions
* tagDefinitions
* tags
* template
* tenants
* test
* usages




<a name="accounts_resource"></a>
# Accounts

<a name="createaccount"></a>
## Create account

```
POST /rest/v1/accounts

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
    "name": "Park Seungpil",
    "firstNameLength": 4,
    "email": "sppark@uengine.org",
    "billCycleDayLocal": 0,
    "currency": "USD",
    "parentAccountId": null,
    "isPaymentDelegatedToParent": false,
    "timeZone": "UTC",
    "address1": "",
    "address2": "",
    "postalCode": "",
    "company": "unionnec",
    "city": "",
    "state": "",
    "country": "KR",
    "locale": "ko_KR",
    "phone": "+821040341807",
    "notes": "",
    "isNotifiedForInvoices": true
  }' 'http://localhost:18080/rest/v1/accounts'


Reponse Example

201 no content
```

POST /rest/v1/accounts

### Description
구매자 계정을 생성한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Body**|**body**  <br>*optional*|[AccountJson](#accountjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account data supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getaccountbykey"></a>
## Retrieve an account by external key

```
GET /rest/v1/accounts

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts?externalKey=e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8&accountWithBalance=true&accountWithBalanceAndCBA=true&audit=NONE'


Reponse Example

{
  "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
  "name": "park seungpil",
  "firstNameLength": 4,
  "externalKey": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
  "email": "sppark@uengine.org",
  "billCycleDayLocal": 10,
  "currency": "USD",
  "parentAccountId": null,
  "isPaymentDelegatedToParent": false,
  "paymentMethodId": "32cdf8e8-cef1-4995-afcb-ac16eefe7672",
  "timeZone": "UTC",
  "address1": "",
  "address2": null,
  "postalCode": "",
  "company": "unionnec",
  "city": "",
  "state": "",
  "country": "KR",
  "locale": "ko_KR",
  "phone": "100000000",
  "notes": "",
  "isMigrated": null,
  "isNotifiedForInvoices": true,
  "accountBalance": 0,
  "accountCBA": 0,
  "auditLogs": []
}
```

GET /rest/v1/accounts

### Description
External key 값으로 구매자 계정을 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**accountWithBalance**  <br>*optional*|boolean|`"false"`|
|**Query**|**accountWithBalanceAndCBA**  <br>*optional*|boolean|`"false"`|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**externalKey**  <br>*optional*|string||


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[AccountJson](#accountjson)|
|**404**|Account not found|No Content|


### Produces

* `application/json`


<a name="getaccounts"></a>
## List accounts

```
GET /rest/v1/accounts/pagination

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/pagination?offset=0&limit=100&accountWithBalance=false&accountWithBalanceAndCBA=false&audit=NONE'


Reponse Example

[
	{
	  "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
	  "name": "park seungpil",
	  "firstNameLength": 4,
	  "externalKey": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
	  "email": "sppark@uengine.org",
	  "billCycleDayLocal": 10,
	  "currency": "USD",
	  "parentAccountId": null,
	  "isPaymentDelegatedToParent": false,
	  "paymentMethodId": "32cdf8e8-cef1-4995-afcb-ac16eefe7672",
	  "timeZone": "UTC",
	  "address1": "",
	  "address2": null,
	  "postalCode": "",
	  "company": "unionnec",
	  "city": "",
	  "state": "",
	  "country": "KR",
	  "locale": "ko_KR",
	  "phone": "100000000",
	  "notes": "",
	  "isMigrated": null,
	  "isNotifiedForInvoices": true,
	  "accountBalance": 0,
	  "accountCBA": 0,
	  "auditLogs": []
	}
]
```

GET /rest/v1/accounts/pagination

### Description
구매자 계정을 페이징 처리하여 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**accountWithBalance**  <br>*optional*|boolean|`"false"`|
|**Query**|**accountWithBalanceAndCBA**  <br>*optional*|boolean|`"false"`|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [AccountJson](#accountjson) > array|


### Produces

* `application/json`


<a name="processpaymentbyexternalkey"></a>
## Trigger a payment using the account external key (authorization, purchase or credit)

```
POST /rest/v1/accounts/payments

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "transactionType": "PURCHASE",
  "amount": 10,
  "currency": "USD",
  "effectiveDate": "2017-03-23T08:06:12.213Z"
}' 
'http://localhost:18080/rest/v1/accounts/payments?externalKey=e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8'


Reponse Example

201 no content
```

POST /rest/v1/accounts/payments


### Description
주어진 구매자 external key 로 authorization, purchase, credit 결제를 수행한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**externalKey**  <br>*optional*|string|
|**Query**|**paymentMethodId**  <br>*optional*|string|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|Payment transaction created successfully|No Content|
|**400**|Invalid account external key supplied|No Content|
|**402**|Transaction declined by gateway|No Content|
|**404**|Account not found|No Content|
|**422**|Payment is aborted by a control plugin|No Content|
|**502**|Failed to submit payment transaction|No Content|
|**503**|Payment in unknown status, failed to receive gateway response|No Content|
|**504**|Payment operation timeout|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="searchaccounts"></a>
## Search accounts

```
GET /rest/v1/accounts/search/{searchKey}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/search/seungpil?offset=0&limit=100&accountWithBalance=false&accountWithBalanceAndCBA=false&audit=NONE'


Reponse Example

[
  {
    "accountId": "9b0d4b1e-36e8-4f31-94be-e61924f2667c",
    "name": "park seungpil1",
    "firstNameLength": 4,
    "externalKey": "9b0d4b1e-36e8-4f31-94be-e61924f2667c",
    "email": "sppark@uengine.org",
    "billCycleDayLocal": 15,
    "currency": "USD",
    "parentAccountId": null,
    "isPaymentDelegatedToParent": false,
    "paymentMethodId": null,
    "timeZone": "UTC",
    "address1": "",
    "address2": null,
    "postalCode": "",
    "company": "uengine company",
    "city": "",
    "state": "",
    "country": "KR",
    "locale": "en_US",
    "phone": "100000000",
    "notes": "",
    "isMigrated": null,
    "isNotifiedForInvoices": false,
    "accountBalance": null,
    "accountCBA": null,
    "auditLogs": []
  }
]
```

GET /rest/v1/accounts/search/{searchKey}


### Description
주어진 검색어에 해당하는 구매자 계정들을 페이징 처리하여 반환한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**searchKey**  <br>*required*|string||
|**Query**|**accountWithBalance**  <br>*optional*|boolean|`"false"`|
|**Query**|**accountWithBalanceAndCBA**  <br>*optional*|boolean|`"false"`|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [AccountJson](#accountjson) > array|


### Produces

* `application/json`


<a name="getaccount"></a>
## Retrieve an account by id

```
GET /rest/v1/accounts/{accountId}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8?accountWithBalance=true&accountWithBalanceAndCBA=true&audit=NONE'


Reponse Example

{
  "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
  "name": "park seungpil",
  "firstNameLength": 4,
  "externalKey": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
  "email": "sppark@uengine.org",
  "billCycleDayLocal": 10,
  "currency": "USD",
  "parentAccountId": null,
  "isPaymentDelegatedToParent": false,
  "paymentMethodId": "32cdf8e8-cef1-4995-afcb-ac16eefe7672",
  "timeZone": "UTC",
  "address1": "",
  "address2": null,
  "postalCode": "",
  "company": "unionnec",
  "city": "",
  "state": "",
  "country": "KR",
  "locale": "ko_KR",
  "phone": "100000000",
  "notes": "",
  "isMigrated": null,
  "isNotifiedForInvoices": true,
  "accountBalance": 0,
  "accountCBA": 0,
  "auditLogs": []
}
```

GET /rest/v1/accounts/{accountId}


### Description
구매자 계정을 id 로 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**accountWithBalance**  <br>*optional*|boolean|`"false"`|
|**Query**|**accountWithBalanceAndCBA**  <br>*optional*|boolean|`"false"`|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[AccountJson](#accountjson)|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


### Produces

* `application/json`


<a name="updateaccount"></a>
## Update account

```
PUT /rest/v1/accounts/{accountId}

Request Example

curl -X PUT 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "name": "Seungpil Park",
  "email": "sppark@uengine.org"
}' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8'


Reponse Example

{
  "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
  "name": "Seungpil Park",
  "firstNameLength": 4,
  "externalKey": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
  "email": "sppark@uengine.org",
  "billCycleDayLocal": 10,
  "currency": "USD",
  "parentAccountId": null,
  "isPaymentDelegatedToParent": false,
  "paymentMethodId": "32cdf8e8-cef1-4995-afcb-ac16eefe7672",
  "timeZone": "UTC",
  "address1": "",
  "address2": null,
  "postalCode": "",
  "company": "unionnec",
  "city": "",
  "state": "",
  "country": "KR",
  "locale": "ko_KR",
  "phone": "100000000",
  "notes": "",
  "isMigrated": null,
  "isNotifiedForInvoices": true,
  "accountBalance": null,
  "accountCBA": null,
  "auditLogs": []
}
```

PUT /rest/v1/accounts/{accountId}


### Description
구매자 계정 정보를 업데이트한다.

이때, billCycleDayLocal(결제 주기일), currency(통화) 는 변경을 허용하지 않는다.

### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**accountId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|[AccountJson](#accountjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account data supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getalltags"></a>
## Retrieve account tags

```
GET /rest/v1/accounts/{accountId}/allTags

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/allTags?objectType=ACCOUNT&audit=NONE&includedDeleted=false'


Reponse Example

[
  {
    "tagId": "b9a1bc9a-1ec4-4a4f-b84f-c3c6269f62c1",
    "objectType": "ACCOUNT",
    "objectId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "tagDefinitionId": "00000000-0000-0000-0000-000000000001",
    "tagDefinitionName": "AUTO_PAY_OFF",
    "auditLogs": []
  },
  {
    "tagId": "1f380314-95ed-4bc8-a974-c4abc324b569",
    "objectType": "ACCOUNT",
    "objectId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "tagDefinitionId": "00000000-0000-0000-0000-000000000002",
    "tagDefinitionName": "AUTO_INVOICING_OFF",
    "auditLogs": []
  }
]
```

GET /rest/v1/accounts/{accountId}/allTags


### Description
구매자 계정과 관련된 모든 태그들을 objectType 별로 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**includedDeleted**  <br>*optional*|boolean|`"false"`|
|**Query**|**objectType**  <br>*optional*|enum (ACCOUNT, ACCOUNT_EMAIL, BLOCKING_STATES, BUNDLE, CUSTOM_FIELD, INVOICE, PAYMENT, TRANSACTION, INVOICE_ITEM, INVOICE_PAYMENT, SUBSCRIPTION, SUBSCRIPTION_EVENT, SERVICE_BROADCAST, PAYMENT_ATTEMPT, PAYMENT_METHOD, REFUND, TAG, TAG_DEFINITION, TENANT, TENANT_KVS)||


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [TagJson](#tagjson) > array|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


### Produces

* `application/json`


<a name="getblockingstates"></a>
## Retrieve blocking states for account

```
GET /rest/v1/accounts/{accountId}/block

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/block?audit=NONE'

Reponse Example

[
  {
    "blockedId": "05ed0ff5-d655-4825-aba6-f8885aeb98d2",
    "stateName": "ENT_STARTED",
    "service": "entitlement-service",
    "blockChange": false,
    "blockEntitlement": false,
    "blockBilling": false,
    "effectiveDate": "2017-03-08T00:00:10.000Z",
    "type": "SUBSCRIPTION",
    "auditLogs": []
  },
  {
    "blockedId": "510bf1cc-e245-4d88-ab80-e4199ac8f57e",
    "stateName": "ENT_STARTED",
    "service": "entitlement-service",
    "blockChange": false,
    "blockEntitlement": false,
    "blockBilling": false,
    "effectiveDate": "2017-03-08T00:00:16.000Z",
    "type": "SUBSCRIPTION",
    "auditLogs": []
  }
]
```

GET /rest/v1/accounts/{accountId}/block


### Description
구매자 계정의 blocking 이력을 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**blockingStateSvcs**  <br>*optional*|< string > array(multi)||
|**Query**|**blockingStateTypes**  <br>*optional*|< enum (SUBSCRIPTION, SUBSCRIPTION_BUNDLE, ACCOUNT) > array(multi)||


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [BlockingStateJson](#blockingstatejson) > array|
|**400**|Invalid account id supplied|No Content|


### Produces

* `application/json`


<a name="addaccountblockingstate"></a>
## Block an account

```
PUT /rest/v1/accounts/{accountId}/block

Request Example

curl -X PUT 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' -d '{
"stateName": "OD3",
"service": "overdue-service",
"blockChange": true,
"blockEntitlement": true,
"blockBilling": true,
"type": "ACCOUNT"
}' 'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/block'



Reponse Example

200 no content
```

PUT /rest/v1/accounts/{accountId}/block


### Description
구매자 계정을 Block 시킨다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**accountId**  <br>*required*|string|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Query**|**requestedDate**  <br>*optional*|string|
|**Body**|**body**  <br>*optional*|[BlockingStateJson](#blockingstatejson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


### Consumes

* `application/json`


<a name="getaccountbundles"></a>
## Retrieve bundles for account

```
GET /rest/v1/accounts/{accountId}/bundles

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/bundles?audit=NONE'


Reponse Example

[
  {
    "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "bundleId": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
    "externalKey": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
    "subscriptions": [
      {
        "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
        "bundleId": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
        "subscriptionId": "05ed0ff5-d655-4825-aba6-f8885aeb98d2",
        "externalKey": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
        "startDate": "2017-03-08",
        "productName": "PRD_0000000017",
        "productCategory": "BASE",
        "billingPeriod": "MONTHLY",
        "phaseType": "TRIAL",
        "priceList": "DEFAULT",
        "planName": "PRD_0000000017_PL_000001",
        "state": "ACTIVE",
        "sourceType": "NATIVE",
        "cancelledDate": null,
        "chargedThroughDate": "2017-06-10",
        "billingStartDate": "2017-03-08",
        "billingEndDate": null,
        "billCycleDayLocal": 10,
        "events": [
          {
            "eventId": "5f604100-138f-41e7-a14c-b9527c0476b0",
            "billingPeriod": "MONTHLY",
            "product": "PRD_0000000017",
            "priceList": "DEFAULT",
            "eventType": "START_ENTITLEMENT",
            "isBlockedBilling": false,
            "isBlockedEntitlement": false,
            "serviceName": "entitlement-service",
            "serviceStateName": "ENT_STARTED",
            "phase": "PRD_0000000017_PL_000001-discount",
            "auditLogs": [],
            "effectiveDate": "2017-03-08"
          },
          {
            "eventId": "adad42eb-24f1-4e03-8270-b5bbe8fe8c9c",
            "billingPeriod": "MONTHLY",
            "product": "PRD_0000000017",
            "priceList": "DEFAULT",
            "eventType": "START_BILLING",
            "isBlockedBilling": false,
            "isBlockedEntitlement": false,
            "serviceName": "billing-service",
            "serviceStateName": "START_BILLING",
            "phase": "PRD_0000000017_PL_000001-trial",
            "auditLogs": [],
            "effectiveDate": "2017-03-08"
          },
          {
            "eventId": "797a4f9b-eb9d-4552-b31e-1253d58c7879",
            "billingPeriod": "MONTHLY",
            "product": "PRD_0000000017",
            "priceList": "DEFAULT",
            "eventType": "SERVICE_STATE_CHANGE",
            "isBlockedBilling": false,
            "isBlockedEntitlement": false,
            "serviceName": "aaa",
            "serviceStateName": "bbb",
            "phase": "PRD_0000000017_PL_000001-discount",
            "auditLogs": [],
            "effectiveDate": "2017-03-23"
          },
          {
            "eventId": "801c5a59-5f3d-475d-86f3-0022be068d86",
            "billingPeriod": "MONTHLY",
            "product": "PRD_0000000017",
            "priceList": "DEFAULT",
            "eventType": "PHASE",
            "isBlockedBilling": false,
            "isBlockedEntitlement": false,
            "serviceName": "entitlement+billing-service",
            "serviceStateName": "PHASE",
            "phase": "PRD_0000000017_PL_000001-discount",
            "auditLogs": [],
            "effectiveDate": "2017-04-07"
          },
          {
            "eventId": "f4471316-9717-4910-96e9-89680388c94e",
            "billingPeriod": "MONTHLY",
            "product": "PRD_0000000017",
            "priceList": "DEFAULT",
            "eventType": "PHASE",
            "isBlockedBilling": false,
            "isBlockedEntitlement": false,
            "serviceName": "entitlement+billing-service",
            "serviceStateName": "PHASE",
            "phase": "PRD_0000000017_PL_000001-evergreen",
            "auditLogs": [],
            "effectiveDate": "2017-06-07"
          }
        ],
        "priceOverrides": [
          {
            "phaseName": "PRD_0000000017_PL_000001-trial",
            "phaseType": "TRIAL",
            "fixedPrice": 0,
            "recurringPrice": null
          },
          {
            "phaseName": "PRD_0000000017_PL_000001-discount",
            "phaseType": "DISCOUNT",
            "fixedPrice": null,
            "recurringPrice": 8
          },
          {
            "phaseName": "PRD_0000000017_PL_000001-evergreen",
            "phaseType": "EVERGREEN",
            "fixedPrice": null,
            "recurringPrice": 10
          }
        ],
        "auditLogs": []
      }
    ],
    "timeline": {
      "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
      "bundleId": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
      "externalKey": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
      "events": [
        {
          "eventId": "5f604100-138f-41e7-a14c-b9527c0476b0",
          "billingPeriod": "MONTHLY",
          "product": "PRD_0000000017",
          "priceList": "DEFAULT",
          "eventType": "START_ENTITLEMENT",
          "isBlockedBilling": false,
          "isBlockedEntitlement": false,
          "serviceName": "entitlement-service",
          "serviceStateName": "ENT_STARTED",
          "phase": "PRD_0000000017_PL_000001-discount",
          "auditLogs": [],
          "effectiveDate": "2017-03-08"
        },
        {
          "eventId": "adad42eb-24f1-4e03-8270-b5bbe8fe8c9c",
          "billingPeriod": "MONTHLY",
          "product": "PRD_0000000017",
          "priceList": "DEFAULT",
          "eventType": "START_BILLING",
          "isBlockedBilling": false,
          "isBlockedEntitlement": false,
          "serviceName": "billing-service",
          "serviceStateName": "START_BILLING",
          "phase": "PRD_0000000017_PL_000001-trial",
          "auditLogs": [],
          "effectiveDate": "2017-03-08"
        },
        {
          "eventId": "797a4f9b-eb9d-4552-b31e-1253d58c7879",
          "billingPeriod": "MONTHLY",
          "product": "PRD_0000000017",
          "priceList": "DEFAULT",
          "eventType": "SERVICE_STATE_CHANGE",
          "isBlockedBilling": false,
          "isBlockedEntitlement": false,
          "serviceName": "aaa",
          "serviceStateName": "bbb",
          "phase": "PRD_0000000017_PL_000001-discount",
          "auditLogs": [],
          "effectiveDate": "2017-03-23"
        },
        {
          "eventId": "801c5a59-5f3d-475d-86f3-0022be068d86",
          "billingPeriod": "MONTHLY",
          "product": "PRD_0000000017",
          "priceList": "DEFAULT",
          "eventType": "PHASE",
          "isBlockedBilling": false,
          "isBlockedEntitlement": false,
          "serviceName": "entitlement+billing-service",
          "serviceStateName": "PHASE",
          "phase": "PRD_0000000017_PL_000001-discount",
          "auditLogs": [],
          "effectiveDate": "2017-04-07"
        },
        {
          "eventId": "f4471316-9717-4910-96e9-89680388c94e",
          "billingPeriod": "MONTHLY",
          "product": "PRD_0000000017",
          "priceList": "DEFAULT",
          "eventType": "PHASE",
          "isBlockedBilling": false,
          "isBlockedEntitlement": false,
          "serviceName": "entitlement+billing-service",
          "serviceStateName": "PHASE",
          "phase": "PRD_0000000017_PL_000001-evergreen",
          "auditLogs": [],
          "effectiveDate": "2017-06-07"
        }
      ],
      "auditLogs": []
    },
    "auditLogs": []
  }
]
```

GET /rest/v1/accounts/{accountId}/bundles


### Description
구매자 계정이 구독중인 bundle 리스트를 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**bundlesFilter**  <br>*optional*|string||
|**Query**|**externalKey**  <br>*optional*|string||


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [BundleJson](#bundlejson) > array|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


### Produces

* `application/json`


<a name="rebalanceexistingcbaonaccount"></a>
## Rebalance account CBA

```
POST /rest/v1/accounts/{accountId}/cbaRebalancing

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' --header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/cbaRebalancing'


Reponse Example

200 no content
```

POST /rest/v1/accounts/{accountId}/cbaRebalancing


### Description
구매자 계정의 가상 화폐(Credit) 를 리밸런싱한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**accountId**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getchildrenaccounts"></a>
## List children accounts

```
GET /rest/v1/accounts/{accountId}/children

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/children?accountWithBalance=false&accountWithBalanceAndCBA=false&audit=NONE'


Reponse Example

[
  {
    "accountId": "6e5d149c-5840-4cd8-a8f2-42578c83a099",
    "name": "child account",
    "firstNameLength": null,
    "externalKey": "6e5d149c-5840-4cd8-a8f2-42578c83a099",
    "email": null,
    "billCycleDayLocal": 0,
    "currency": "USD",
    "parentAccountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "isPaymentDelegatedToParent": false,
    "paymentMethodId": null,
    "timeZone": "UTC",
    "address1": null,
    "address2": null,
    "postalCode": null,
    "company": null,
    "city": null,
    "state": null,
    "country": null,
    "locale": null,
    "phone": null,
    "notes": null,
    "isMigrated": null,
    "isNotifiedForInvoices": false,
    "accountBalance": null,
    "accountCBA": null,
    "auditLogs": []
  }
]
```

GET /rest/v1/accounts/{accountId}/children


### Description
구매자 계정의 하위 계정들을 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**accountWithBalance**  <br>*optional*|boolean|`"false"`|
|**Query**|**accountWithBalanceAndCBA**  <br>*optional*|boolean|`"false"`|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [AccountJson](#accountjson) > array|
|**400**|Invalid parent account id supplied|No Content|
|**404**|Parent Account not found|No Content|


### Produces

* `application/json`


<a name="createaccountcustomfields"></a>
## Add custom fields to account

```
POST /rest/v1/accounts/{accountId}/customFields

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '[
  {
    "name": "CustomKey1",
    "value": "Value1"
  }
]' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/customFields'


Reponse Example

201 no content
```

POST /rest/v1/accounts/{accountId}/customFields


### Description
구매자 계정에 custom field 를 추가한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**accountId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|< [CustomFieldJson](#customfieldjson) > array|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getaccountcustomfields"></a>
## Retrieve account custom fields

```
GET /rest/v1/accounts/{accountId}/customFields

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/customFields?audit=NONE'


Reponse Example

[
  {
    "customFieldId": "6ff3fa83-4e61-447f-aa66-56bbe8212b8b",
    "objectId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "objectType": "ACCOUNT",
    "name": "CustomKey1",
    "value": "Value1",
    "auditLogs": []
  }
]
```

GET /rest/v1/accounts/{accountId}/customFields


### Description
구매자 계정의 custom fields 를 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [CustomFieldJson](#customfieldjson) > array|
|**400**|Invalid account id supplied|No Content|


### Produces

* `application/json`


<a name="deleteaccountcustomfields"></a>
## Remove custom fields from account

```
DELETE /rest/v1/accounts/{accountId}/customFields

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/customFields?customFieldList=6ff3fa83-4e61-447f-aa66-56bbe8212b8b'


Reponse Example

200 no content
```

DELETE /rest/v1/accounts/{accountId}/customFields


### Description
구매자 계정의 custom field 를 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**accountId**  <br>*required*|string|
|**Query**|**customFieldList**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getemailnotificationsforaccount"></a>
## Retrieve account email notification

```
GET /rest/v1/accounts/{accountId}/emailNotifications

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/emailNotifications'


Reponse Example

{
  "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
  "isNotifiedForInvoices": true,
  "auditLogs": null
}
```

GET /rest/v1/accounts/{accountId}/emailNotifications


### Description
구매자 계정으로 인보이스 발송 여부를 조회한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**accountId**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[InvoiceEmailJson](#invoiceemailjson)|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


### Produces

* `application/json`


<a name="setemailnotificationsforaccount"></a>
## Set account email notification

```
PUT /rest/v1/accounts/{accountId}/emailNotifications

Request Example

curl -X PUT 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "isNotifiedForInvoices": true
}' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/emailNotifications'


Reponse Example

200 no content
```

PUT /rest/v1/accounts/{accountId}/emailNotifications


### Description
구매자 계정으로 인보이스 발송 여부를 결정한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**accountId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|[InvoiceEmailJson](#invoiceemailjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="addemail"></a>
## Add account email

```
POST /rest/v1/accounts/{accountId}/emails

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
  "email": "darkgodarkgo2@gmail.com"
}' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/emails'


Reponse Example

201 no content
```

POST /rest/v1/accounts/{accountId}/emails


### Description
인보이스 및 이메일 알림에 대해 CC(참조) 를 받는 이메일 계정을 추가한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**accountId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|[AccountEmailJson](#accountemailjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getemails"></a>
## Retrieve an account emails

```
GET /rest/v1/accounts/{accountId}/emails

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/emails'


Reponse Example

[
  {
    "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "email": "darkgodarkgo@gmail.com",
    "auditLogs": null
  }
]
```

GET /rest/v1/accounts/{accountId}/emails


### Description
인보이스 및 이메일 알림에 대해 CC(참조) 를 받는 이메일 계정 리스트를 불러온다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**accountId**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [AccountEmailJson](#accountemailjson) > array|
|**400**|Invalid account id supplied|No Content|


### Produces

* `application/json`


<a name="removeemail"></a>
## Delete email from account

```
DELETE /rest/v1/accounts/{accountId}/emails/{email}

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/emails/darkgodarkgo2%40gmail.com'


Reponse Example

200 no content
```

DELETE /rest/v1/accounts/{accountId}/emails/{email}


### Description
인보이스 및 이메일 알림에 대해 CC(참조) 를 받는 이메일 계정을 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**accountId**  <br>*required*|string|
|**Path**|**email**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|


### Produces

* `application/json`

<a name="payallinvoices"></a>
## Trigger a payment for all unpaid invoices

```
POST /rest/v1/accounts/{accountId}/invoicePayments

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/invoicePayments?externalPayment=false'


Reponse Example

200 no content
```

POST /rest/v1/accounts/{accountId}/invoicePayments


### Description
구매자 계정의 모든 미결제된 인보이스에 대해 결제시도를 한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string||
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string||
|**Header**|**X-Killbill-Reason**  <br>*optional*|string||
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**externalPayment**  <br>*optional*|boolean|`"false"`|
|**Query**|**paymentAmount**  <br>*optional*|number||
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getaccountinvoicepayments"></a>
## Retrieve account invoice payments

```
GET /rest/v1/accounts/{accountId}/invoicePayments

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/invoicePayments?audit=NONE&withPluginInfo=false&withAttempts=false'


Reponse Example

[
  {
    "targetInvoiceId": null,
    "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "paymentId": "e04ba12b-8607-4159-a853-64451af462df",
    "paymentNumber": "259",
    "paymentExternalKey": "e04ba12b-8607-4159-a853-64451af462df",
    "authAmount": 0,
    "capturedAmount": 0,
    "purchasedAmount": 10,
    "refundedAmount": 5,
    "creditedAmount": 0,
    "currency": "USD",
    "paymentMethodId": "32cdf8e8-cef1-4995-afcb-ac16eefe7672",
    "transactions": [
      {
        "transactionId": "7c6bea1e-e8cd-409c-828c-d86c542b4e49",
        "transactionExternalKey": "7c6bea1e-e8cd-409c-828c-d86c542b4e49",
        "paymentId": "e04ba12b-8607-4159-a853-64451af462df",
        "paymentExternalKey": "e04ba12b-8607-4159-a853-64451af462df",
        "transactionType": "PURCHASE",
        "amount": 10,
        "currency": "USD",
        "effectiveDate": "2017-03-07T20:54:26.000Z",
        "processedAmount": 10,
        "processedCurrency": "USD",
        "status": "SUCCESS",
        "gatewayErrorCode": null,
        "gatewayErrorMsg": "Success",
        "firstPaymentReferenceId": null,
        "secondPaymentReferenceId": null,
        "properties": null,
        "auditLogs": []
      },
      {
        "transactionId": "75365d69-8447-4624-9580-67948d3918a2",
        "transactionExternalKey": "75365d69-8447-4624-9580-67948d3918a2",
        "paymentId": "e04ba12b-8607-4159-a853-64451af462df",
        "paymentExternalKey": "e04ba12b-8607-4159-a853-64451af462df",
        "transactionType": "REFUND",
        "amount": 5,
        "currency": "USD",
        "effectiveDate": "2017-03-07T20:55:05.000Z",
        "processedAmount": 5,
        "processedCurrency": "USD",
        "status": "SUCCESS",
        "gatewayErrorCode": null,
        "gatewayErrorMsg": "Success",
        "firstPaymentReferenceId": null,
        "secondPaymentReferenceId": null,
        "properties": null,
        "auditLogs": []
      }
    ],
    "paymentAttempts": null,
    "auditLogs": []
  }
]
```

GET /rest/v1/accounts/{accountId}/invoicePayments


### Description
구매자 계정의 모든 인보이스와 연계된 결제내역을 불러온다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**withAttempts**  <br>*optional*|boolean|`"false"`|
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [InvoicePaymentJson](#invoicepaymentjson) > array|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


### Produces

* `application/json`


<a name="getaccountinvoices"></a>
## Retrieve account invoices

```
GET /rest/v1/accounts/{accountId}/invoices

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/invoices?withItems=true&withMigrationInvoices=false&unpaidInvoicesOnly=false&audit=NONE'


Reponse Example

[
  {
    "amount": 12,
    "currency": "USD",
    "status": "COMMITTED",
    "creditAdj": 4,
    "refundAdj": 0,
    "invoiceId": "4b250d1a-d2e0-4e38-a6da-581653db5889",
    "invoiceDate": "2017-05-11",
    "targetDate": "2017-05-10",
    "invoiceNumber": "432",
    "balance": 0,
    "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "credits": null,
    "items": [
      {
        "invoiceItemId": "58632690-c85f-4497-a9f4-a46803702e7b",
        "invoiceId": "4b250d1a-d2e0-4e38-a6da-581653db5889",
        "linkedInvoiceItemId": null,
        "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
        "childAccountId": null,
        "bundleId": "a97d5fba-7772-4a27-a2f5-5335f6552e66",
        "subscriptionId": "510bf1cc-e245-4d88-ab80-e4199ac8f57e",
        "planName": "PRD_0000000017_PL_000001",
        "phaseName": "PRD_0000000017_PL_000001-discount",
        "usageName": null,
        "itemType": "RECURRING",
        "description": "PRD_0000000017_PL_000001-discount",
        "startDate": "2017-04-10",
        "endDate": "2017-05-10",
        "amount": 8,
        "currency": "USD",
        "childItems": null,
        "auditLogs": []
      },
      {
        "invoiceItemId": "7b19f966-5fb1-4fe5-b3b4-2fbf685db3aa",
        "invoiceId": "4b250d1a-d2e0-4e38-a6da-581653db5889",
        "linkedInvoiceItemId": null,
        "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
        "childAccountId": null,
        "bundleId": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
        "subscriptionId": "05ed0ff5-d655-4825-aba6-f8885aeb98d2",
        "planName": "PRD_0000000017_PL_000001",
        "phaseName": "PRD_0000000017_PL_000001-discount",
        "usageName": null,
        "itemType": "RECURRING",
        "description": "PRD_0000000017_PL_000001-discount",
        "startDate": "2017-04-10",
        "endDate": "2017-05-10",
        "amount": 8,
        "currency": "USD",
        "childItems": null,
        "auditLogs": []
      },
      {
        "invoiceItemId": "4dacca77-8f5e-4fb6-b9ac-1de70ce51fca",
        "invoiceId": "4b250d1a-d2e0-4e38-a6da-581653db5889",
        "linkedInvoiceItemId": "7b19f966-5fb1-4fe5-b3b4-2fbf685db3aa",
        "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
        "childAccountId": null,
        "bundleId": null,
        "subscriptionId": null,
        "planName": null,
        "phaseName": null,
        "usageName": null,
        "itemType": "ITEM_ADJ",
        "description": "Invoice item adjustment",
        "startDate": "2017-03-16",
        "endDate": "2017-03-16",
        "amount": -4,
        "currency": "USD",
        "childItems": null,
        "auditLogs": []
      },
      {
        "invoiceItemId": "514aefc8-9767-42b2-b24c-8c6b60dbae20",
        "invoiceId": "4b250d1a-d2e0-4e38-a6da-581653db5889",
        "linkedInvoiceItemId": null,
        "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
        "childAccountId": null,
        "bundleId": null,
        "subscriptionId": null,
        "planName": null,
        "phaseName": null,
        "usageName": null,
        "itemType": "CBA_ADJ",
        "description": "Adjustment (account credit)",
        "startDate": "2017-03-16",
        "endDate": "2017-03-16",
        "amount": 4,
        "currency": "USD",
        "childItems": null,
        "auditLogs": []
      }
    ],
    "isParentInvoice": false,
    "auditLogs": [],
    "bundleKeys": null
  }
]
```

GET /rest/v1/accounts/{accountId}/invoices


### Description
구매자 계정의 모든 인보이스를 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**unpaidInvoicesOnly**  <br>*optional*|boolean|`"false"`|
|**Query**|**withItems**  <br>*optional*|boolean|`"false"`|
|**Query**|**withMigrationInvoices**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[InvoiceJson](#invoicejson)|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


### Produces

* `application/json`


<a name="getoverdueaccount"></a>
## Retrieve overdue state for account

```
GET /rest/v1/accounts/{accountId}/overdue

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/overdue'


Reponse Example

{
  "name": "__KILLBILL__CLEAR__OVERDUE_STATE__",
  "externalMessage": "",
  "daysBetweenPaymentRetries": [
    1,
    1,
    1
  ],
  "disableEntitlementAndChangesBlocked": false,
  "blockChanges": false,
  "clearState": true,
  "reevaluationIntervalDays": null
}
```

GET /rest/v1/accounts/{accountId}/overdue

### Description
구매자 계정의 연체 상태를 조회한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**accountId**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[OverdueStateJson](#overduestatejson)|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


### Produces

* `application/json`


<a name="createpaymentmethod"></a>
## Add a payment method

```
POST /rest/v1/accounts/{accountId}/paymentMethods

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "pluginName": "__EXTERNAL_PAYMENT__",
  "pluginInfo": {
    "properties": [
      {
        "key": "key1",
        "value": "value1"
      }
    ]
  }
}' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/paymentMethods?isDefault=true&payAllUnpaidInvoices=false'


Reponse Example

201 Created
```

POST /rest/v1/accounts/{accountId}/paymentMethods


### Description
구매자 계정에 결제수단을 추가한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string||
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string||
|**Header**|**X-Killbill-Reason**  <br>*optional*|string||
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**isDefault**  <br>*optional*|boolean|`"false"`|
|**Query**|**payAllUnpaidInvoices**  <br>*optional*|boolean|`"false"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Body**|**body**  <br>*optional*|[PaymentMethodJson](#paymentmethodjson)||


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getaccountpaymentmethods"></a>
## Retrieve account payment methods

```
GET /rest/v1/accounts/{accountId}/paymentMethods

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/paymentMethods?withPluginInfo=true&audit=NONE'


Reponse Example

[
  {
    "paymentMethodId": "32cdf8e8-cef1-4995-afcb-ac16eefe7672",
    "externalKey": "B-75L12802X57945620",
    "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "isDefault": true,
    "pluginName": "killbill-paypal-express",
    "pluginInfo": {
      "externalPaymentMethodId": "B-75L12802X57945620",
      "isDefaultPaymentMethod": false,
      "properties": [
        {
          "key": "token",
          "value": "B-75L12802X57945620",
          "isUpdatable": false
        },
        {
          "key": "ccFirstName",
          "value": null,
          "isUpdatable": false
        },
        {
          "key": "ccLastName",
          "value": null,
          "isUpdatable": false
        },
        {
          "key": "ccName",
          "value": null,
          "isUpdatable": false
        },
        {
          "key": "ccType",
          "value": null,
          "isUpdatable": false
        },
        {
          "key": "ccExpirationMonth",
          "value": null,
          "isUpdatable": false
        },
        {
          "key": "ccExpirationYear",
          "value": null,
          "isUpdatable": false
        },
        {
          "key": "ccLast4",
          "value": null,
          "isUpdatable": false
        },
        {
          "key": "ccNumber",
          "value": null,
          "isUpdatable": false
        },
        {
          "key": "address1",
          "value": null,
          "isUpdatable": false
        },
        {
          "key": "address2",
          "value": null,
          "isUpdatable": false
        },
        {
          "key": "city",
          "value": null,
          "isUpdatable": false
        },
        {
          "key": "state",
          "value": null,
          "isUpdatable": false
        },
        {
          "key": "zip",
          "value": null,
          "isUpdatable": false
        },
        {
          "key": "country",
          "value": null,
          "isUpdatable": false
        },
        {
          "key": "paypalExpressToken",
          "value": "EC-04T525946L128730M",
          "isUpdatable": false
        },
        {
          "key": "payerId",
          "value": "D8GEWYW4CJV58",
          "isUpdatable": false
        },
        {
          "key": "baid",
          "value": "B-75L12802X57945620",
          "isUpdatable": false
        }
      ]
    },
    "auditLogs": []
  },
  {
    "paymentMethodId": "6dd11e20-0f6f-4e8f-972e-629b05598f14",
    "externalKey": "6dd11e20-0f6f-4e8f-972e-629b05598f14",
    "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "isDefault": false,
    "pluginName": "__EXTERNAL_PAYMENT__",
    "pluginInfo": {
      "externalPaymentMethodId": "unknown",
      "isDefaultPaymentMethod": false,
      "properties": []
    },
    "auditLogs": []
  }
]
```

GET /rest/v1/accounts/{accountId}/paymentMethods


### Description
구매자 계정의 모든 결제수단을 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [PaymentMethodJson](#paymentmethodjson) > array|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


### Produces

* `application/json`


<a name="refreshpaymentmethods"></a>
## Refresh account payment methods

```
POST /rest/v1/accounts/{accountId}/paymentMethods/refresh

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/paymentMethods/refresh?pluginName=killbill-paypal-express'


Reponse Example

200 no content
```

POST /rest/v1/accounts/{accountId}/paymentMethods/refresh


### Description
구매자 계정의 결제 수단을 리프레쉬한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**accountId**  <br>*required*|string|
|**Query**|**pluginName**  <br>*optional*|string|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


### Produces

* `application/json`


<a name="setdefaultpaymentmethod"></a>
## Set the default payment method

```
PUT /rest/v1/accounts/{accountId}/paymentMethods/{paymentMethodId}/setDefault

Request Example

curl -X PUT 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/paymentMethods/32cdf8e8-cef1-4995-afcb-ac16eefe7672/setDefault?payAllUnpaidInvoices=false'


Reponse Example

200 no content
```

PUT /rest/v1/accounts/{accountId}/paymentMethods/{paymentMethodId}/setDefault


### Description
구매자 계정의 결제 수단을 디폴트로 지정한다. (인보이스 생성시 디폴트 결제 수단으로 결제된다.)


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string||
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string||
|**Header**|**X-Killbill-Reason**  <br>*optional*|string||
|**Path**|**accountId**  <br>*required*|string||
|**Path**|**paymentMethodId**  <br>*required*|string||
|**Query**|**payAllUnpaidInvoices**  <br>*optional*|boolean|`"false"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id or payment method id supplied|No Content|
|**404**|Account not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`

<a name="processpayment"></a>
## Trigger a payment (authorization, purchase or credit)

```
POST /rest/v1/accounts/{accountId}/payments

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "transactionType": "PURCHASE",
  "amount": 10,
  "currency": "USD"
}' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/payments'


Reponse Example

201 no content
```

POST /rest/v1/accounts/{accountId}/payments


### Description
구매자 계정으로 하여금 authorization, purchase, credit 결제를 수행한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**accountId**  <br>*required*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**paymentMethodId**  <br>*optional*|string|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|Payment transaction created successfully|No Content|
|**400**|Invalid account id supplied|No Content|
|**402**|Transaction declined by gateway|No Content|
|**404**|Account not found|No Content|
|**422**|Payment is aborted by a control plugin|No Content|
|**502**|Failed to submit payment transaction|No Content|
|**503**|Payment in unknown status, failed to receive gateway response|No Content|
|**504**|Payment operation timeout|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getaccountpayments"></a>
## Retrieve account payments

```
GET /rest/v1/accounts/{accountId}/payments

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/payments?audit=NONE&withPluginInfo=false&withAttempts=false'


Reponse Example

[
  {
    "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "paymentId": "e04ba12b-8607-4159-a853-64451af462df",
    "paymentNumber": "259",
    "paymentExternalKey": "e04ba12b-8607-4159-a853-64451af462df",
    "authAmount": 0,
    "capturedAmount": 0,
    "purchasedAmount": 10,
    "refundedAmount": 5,
    "creditedAmount": 0,
    "currency": "USD",
    "paymentMethodId": "32cdf8e8-cef1-4995-afcb-ac16eefe7672",
    "transactions": [
      {
        "transactionId": "7c6bea1e-e8cd-409c-828c-d86c542b4e49",
        "transactionExternalKey": "7c6bea1e-e8cd-409c-828c-d86c542b4e49",
        "paymentId": "e04ba12b-8607-4159-a853-64451af462df",
        "paymentExternalKey": "e04ba12b-8607-4159-a853-64451af462df",
        "transactionType": "PURCHASE",
        "amount": 10,
        "currency": "USD",
        "effectiveDate": "2017-03-07T20:54:26.000Z",
        "processedAmount": 10,
        "processedCurrency": "USD",
        "status": "SUCCESS",
        "gatewayErrorCode": null,
        "gatewayErrorMsg": "Success",
        "firstPaymentReferenceId": null,
        "secondPaymentReferenceId": null,
        "properties": null,
        "auditLogs": []
      },
      {
        "transactionId": "75365d69-8447-4624-9580-67948d3918a2",
        "transactionExternalKey": "75365d69-8447-4624-9580-67948d3918a2",
        "paymentId": "e04ba12b-8607-4159-a853-64451af462df",
        "paymentExternalKey": "e04ba12b-8607-4159-a853-64451af462df",
        "transactionType": "REFUND",
        "amount": 5,
        "currency": "USD",
        "effectiveDate": "2017-03-07T20:55:05.000Z",
        "processedAmount": 5,
        "processedCurrency": "USD",
        "status": "SUCCESS",
        "gatewayErrorCode": null,
        "gatewayErrorMsg": "Success",
        "firstPaymentReferenceId": null,
        "secondPaymentReferenceId": null,
        "properties": null,
        "auditLogs": []
      }
    ],
    "paymentAttempts": null,
    "auditLogs": []
  }
]
```

GET /rest/v1/accounts/{accountId}/payments


### Description
구매자 계정의 결제이력을 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**withAttempts**  <br>*optional*|boolean|`"false"`|
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [PaymentJson](#paymentjson) > array|
|**400**|Invalid account id supplied|No Content|


### Produces

* `application/json`


<a name="createaccounttags"></a>
## Add tags to account

```
POST /rest/v1/accounts/{accountId}/tags

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' --header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/tags?tagList=00000000-0000-0000-0000-000000000001%2C00000000-0000-0000-0000-000000000002'



Reponse Example

201 Created
```

POST /rest/v1/accounts/{accountId}/tags


### Description
구매자 계정에 태그를 추가한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**accountId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|


### Produces

* `application/json`


<a name="getaccounttags"></a>
## Retrieve account tags

```
GET /rest/v1/accounts/{accountId}/tags

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/tags?audit=NONE&includedDeleted=false'


Reponse Example

[
  {
    "tagId": "8692804e-69d4-4c12-8f89-cfb0b3f4f674",
    "objectType": "ACCOUNT",
    "objectId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "tagDefinitionId": "00000000-0000-0000-0000-000000000001",
    "tagDefinitionName": "AUTO_PAY_OFF",
    "auditLogs": []
  },
  {
    "tagId": "03e7efa1-2e2a-4751-b105-5a8e39f1d5e0",
    "objectType": "ACCOUNT",
    "objectId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "tagDefinitionId": "00000000-0000-0000-0000-000000000002",
    "tagDefinitionName": "AUTO_INVOICING_OFF",
    "auditLogs": []
  }
]
```

GET /rest/v1/accounts/{accountId}/tags


### Description
구매자 계정의 tag 를 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**includedDeleted**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [TagJson](#tagjson) > array|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


### Produces

* `application/json`


<a name="deleteaccounttags"></a>
## Remove tags from account

```
DELETE /rest/v1/accounts/{accountId}/tags

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/tags?tagList=00000000-0000-0000-0000-000000000001%2C00000000-0000-0000-0000-000000000002'


Reponse Example

200 no content
```

DELETE /rest/v1/accounts/{accountId}/tags


### Description
구매자 계정의 태그를 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**accountId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied or account does not have a default payment method (AUTO_PAY_OFF tag only)|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getaccounttimeline"></a>
## Retrieve account timeline

```
GET /rest/v1/accounts/{accountId}/timeline

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8/timeline?audit=FULL&parallel=false'


Reponse Example

{
  "account": {
    "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "name": "Seungpil Park",
    "firstNameLength": 4,
    "externalKey": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "email": "sppark@uengine.org",
    "billCycleDayLocal": 10,
    "currency": "USD",
    "parentAccountId": null,
    "isPaymentDelegatedToParent": false,
    "paymentMethodId": "32cdf8e8-cef1-4995-afcb-ac16eefe7672",
    "timeZone": "UTC",
    "address1": "",
    "address2": null,
    "postalCode": "",
    "company": "unionnec",
    "city": "",
    "state": "",
    "country": "KR",
    "locale": "ko_KR",
    "phone": "100000000",
    "notes": "",
    "isMigrated": null,
    "isNotifiedForInvoices": true,
    "accountBalance": null,
    "accountCBA": null,
    "auditLogs": [
      {
        "changeType": "INSERT",
        "changeDate": "2017-03-07T20:43:33.000Z",
        "changedBy": "uEngine",
        "reasonCode": null,
        "comments": null,
        "userToken": "583f1107-53ec-4879-be09-6b4c101b25e8"
      },
      {
        "changeType": "UPDATE",
        "changeDate": "2017-03-07T20:52:33.000Z",
        "changedBy": "uEngine",
        "reasonCode": null,
        "comments": null,
        "userToken": "e702f39b-bc3f-4ca3-b42c-9d984ca747f2"
      }
    ]
  },
  "bundles": [
    {
      "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
      "bundleId": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
      "externalKey": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
      "subscriptions": [
        {
          "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
          "bundleId": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
          "subscriptionId": "05ed0ff5-d655-4825-aba6-f8885aeb98d2",
          "externalKey": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
          "startDate": "2017-03-08",
          "productName": "PRD_0000000017",
          "productCategory": "BASE",
          "billingPeriod": "MONTHLY",
          "phaseType": "TRIAL",
          "priceList": "DEFAULT",
          "planName": "PRD_0000000017_PL_000001",
          "state": "ACTIVE",
          "sourceType": "NATIVE",
          "cancelledDate": null,
          "chargedThroughDate": "2017-06-10",
          "billingStartDate": "2017-03-08",
          "billingEndDate": null,
          "billCycleDayLocal": 10,
          "events": [
            {
              "eventId": "5f604100-138f-41e7-a14c-b9527c0476b0",
              "billingPeriod": "MONTHLY",
              "product": "PRD_0000000017",
              "priceList": "DEFAULT",
              "eventType": "START_ENTITLEMENT",
              "isBlockedBilling": false,
              "isBlockedEntitlement": false,
              "serviceName": "entitlement-service",
              "serviceStateName": "ENT_STARTED",
              "phase": "PRD_0000000017_PL_000001-discount",
              "auditLogs": [
                {
                  "changeType": "INSERT",
                  "changeDate": "2017-03-08T00:00:10.000Z",
                  "changedBy": "uEngine",
                  "reasonCode": null,
                  "comments": null,
                  "userToken": "bf30a156-5bb5-4a0e-b131-a915f6176151"
                }
              ],
              "effectiveDate": "2017-03-08"
            },
            {
              "eventId": "adad42eb-24f1-4e03-8270-b5bbe8fe8c9c",
              "billingPeriod": "MONTHLY",
              "product": "PRD_0000000017",
              "priceList": "DEFAULT",
              "eventType": "START_BILLING",
              "isBlockedBilling": false,
              "isBlockedEntitlement": false,
              "serviceName": "billing-service",
              "serviceStateName": "START_BILLING",
              "phase": "PRD_0000000017_PL_000001-trial",
              "auditLogs": [
                {
                  "changeType": "INSERT",
                  "changeDate": "2017-03-08T00:00:10.000Z",
                  "changedBy": "uEngine",
                  "reasonCode": null,
                  "comments": null,
                  "userToken": "bf30a156-5bb5-4a0e-b131-a915f6176151"
                }
              ],
              "effectiveDate": "2017-03-08"
            },
            {
              "eventId": "797a4f9b-eb9d-4552-b31e-1253d58c7879",
              "billingPeriod": "MONTHLY",
              "product": "PRD_0000000017",
              "priceList": "DEFAULT",
              "eventType": "SERVICE_STATE_CHANGE",
              "isBlockedBilling": false,
              "isBlockedEntitlement": false,
              "serviceName": "aaa",
              "serviceStateName": "bbb",
              "phase": "PRD_0000000017_PL_000001-discount",
              "auditLogs": [
                {
                  "changeType": "INSERT",
                  "changeDate": "2017-03-23T08:06:29.000Z",
                  "changedBy": "uEngine",
                  "reasonCode": null,
                  "comments": null,
                  "userToken": "0b596d66-fa33-474f-9b6c-42c91ec88d08"
                }
              ],
              "effectiveDate": "2017-03-23"
            },
            {
              "eventId": "801c5a59-5f3d-475d-86f3-0022be068d86",
              "billingPeriod": "MONTHLY",
              "product": "PRD_0000000017",
              "priceList": "DEFAULT",
              "eventType": "PHASE",
              "isBlockedBilling": false,
              "isBlockedEntitlement": false,
              "serviceName": "entitlement+billing-service",
              "serviceStateName": "PHASE",
              "phase": "PRD_0000000017_PL_000001-discount",
              "auditLogs": [
                {
                  "changeType": "INSERT",
                  "changeDate": "2017-03-08T00:00:10.000Z",
                  "changedBy": "uEngine",
                  "reasonCode": null,
                  "comments": null,
                  "userToken": "bf30a156-5bb5-4a0e-b131-a915f6176151"
                }
              ],
              "effectiveDate": "2017-04-07"
            },
            {
              "eventId": "f4471316-9717-4910-96e9-89680388c94e",
              "billingPeriod": "MONTHLY",
              "product": "PRD_0000000017",
              "priceList": "DEFAULT",
              "eventType": "PHASE",
              "isBlockedBilling": false,
              "isBlockedEntitlement": false,
              "serviceName": "entitlement+billing-service",
              "serviceStateName": "PHASE",
              "phase": "PRD_0000000017_PL_000001-evergreen",
              "auditLogs": [
                {
                  "changeType": "INSERT",
                  "changeDate": "2017-06-08T00:00:02.000Z",
                  "changedBy": "SubscriptionEventQueue",
                  "reasonCode": null,
                  "comments": null,
                  "userToken": "ce3cc5cd-95b6-4a16-a086-15f4148367be"
                }
              ],
              "effectiveDate": "2017-06-07"
            }
          ],
          "priceOverrides": [
            {
              "phaseName": "PRD_0000000017_PL_000001-trial",
              "phaseType": "TRIAL",
              "fixedPrice": 0,
              "recurringPrice": null
            },
            {
              "phaseName": "PRD_0000000017_PL_000001-discount",
              "phaseType": "DISCOUNT",
              "fixedPrice": null,
              "recurringPrice": 8
            },
            {
              "phaseName": "PRD_0000000017_PL_000001-evergreen",
              "phaseType": "EVERGREEN",
              "fixedPrice": null,
              "recurringPrice": 10
            }
          ],
          "auditLogs": [
            {
              "changeType": "INSERT",
              "changeDate": "2017-03-08T00:00:10.000Z",
              "changedBy": "uEngine",
              "reasonCode": null,
              "comments": null,
              "userToken": "bf30a156-5bb5-4a0e-b131-a915f6176151"
            },
            {
              "changeType": "UPDATE",
              "changeDate": "2017-03-08T00:00:12.000Z",
              "changedBy": "SubscriptionBaseTransition",
              "reasonCode": null,
              "comments": null,
              "userToken": "bf30a156-5bb5-4a0e-b131-a915f6176151"
            },
            {
              "changeType": "UPDATE",
              "changeDate": "2017-06-08T00:00:08.000Z",
              "changedBy": "Next Billing Date",
              "reasonCode": null,
              "comments": null,
              "userToken": "eff31a88-d033-4f26-b363-756c91546dfe"
            },
            {
              "changeType": "UPDATE",
              "changeDate": "2017-05-11T00:00:02.000Z",
              "changedBy": "Next Billing Date",
              "reasonCode": null,
              "comments": null,
              "userToken": "52a2454e-723e-4df2-ae8d-0d2e3d9ca374"
            },
            {
              "changeType": "UPDATE",
              "changeDate": "2017-06-16T00:00:06.000Z",
              "changedBy": "SubscriptionBaseTransition",
              "reasonCode": null,
              "comments": null,
              "userToken": "9361cc1a-ffc8-42b0-b40d-990231322c71"
            }
          ]
        }
      ],
      "timeline": {
        "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
        "bundleId": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
        "externalKey": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
        "events": [
          {
            "eventId": "5f604100-138f-41e7-a14c-b9527c0476b0",
            "billingPeriod": "MONTHLY",
            "product": "PRD_0000000017",
            "priceList": "DEFAULT",
            "eventType": "START_ENTITLEMENT",
            "isBlockedBilling": false,
            "isBlockedEntitlement": false,
            "serviceName": "entitlement-service",
            "serviceStateName": "ENT_STARTED",
            "phase": "PRD_0000000017_PL_000001-discount",
            "auditLogs": [
              {
                "changeType": "INSERT",
                "changeDate": "2017-03-08T00:00:10.000Z",
                "changedBy": "uEngine",
                "reasonCode": null,
                "comments": null,
                "userToken": "bf30a156-5bb5-4a0e-b131-a915f6176151"
              }
            ],
            "effectiveDate": "2017-03-08"
          },
          {
            "eventId": "adad42eb-24f1-4e03-8270-b5bbe8fe8c9c",
            "billingPeriod": "MONTHLY",
            "product": "PRD_0000000017",
            "priceList": "DEFAULT",
            "eventType": "START_BILLING",
            "isBlockedBilling": false,
            "isBlockedEntitlement": false,
            "serviceName": "billing-service",
            "serviceStateName": "START_BILLING",
            "phase": "PRD_0000000017_PL_000001-trial",
            "auditLogs": [
              {
                "changeType": "INSERT",
                "changeDate": "2017-03-08T00:00:10.000Z",
                "changedBy": "uEngine",
                "reasonCode": null,
                "comments": null,
                "userToken": "bf30a156-5bb5-4a0e-b131-a915f6176151"
              }
            ],
            "effectiveDate": "2017-03-08"
          },
          {
            "eventId": "797a4f9b-eb9d-4552-b31e-1253d58c7879",
            "billingPeriod": "MONTHLY",
            "product": "PRD_0000000017",
            "priceList": "DEFAULT",
            "eventType": "SERVICE_STATE_CHANGE",
            "isBlockedBilling": false,
            "isBlockedEntitlement": false,
            "serviceName": "aaa",
            "serviceStateName": "bbb",
            "phase": "PRD_0000000017_PL_000001-discount",
            "auditLogs": [
              {
                "changeType": "INSERT",
                "changeDate": "2017-03-23T08:06:29.000Z",
                "changedBy": "uEngine",
                "reasonCode": null,
                "comments": null,
                "userToken": "0b596d66-fa33-474f-9b6c-42c91ec88d08"
              }
            ],
            "effectiveDate": "2017-03-23"
          },
          {
            "eventId": "801c5a59-5f3d-475d-86f3-0022be068d86",
            "billingPeriod": "MONTHLY",
            "product": "PRD_0000000017",
            "priceList": "DEFAULT",
            "eventType": "PHASE",
            "isBlockedBilling": false,
            "isBlockedEntitlement": false,
            "serviceName": "entitlement+billing-service",
            "serviceStateName": "PHASE",
            "phase": "PRD_0000000017_PL_000001-discount",
            "auditLogs": [
              {
                "changeType": "INSERT",
                "changeDate": "2017-03-08T00:00:10.000Z",
                "changedBy": "uEngine",
                "reasonCode": null,
                "comments": null,
                "userToken": "bf30a156-5bb5-4a0e-b131-a915f6176151"
              }
            ],
            "effectiveDate": "2017-04-07"
          },
          {
            "eventId": "f4471316-9717-4910-96e9-89680388c94e",
            "billingPeriod": "MONTHLY",
            "product": "PRD_0000000017",
            "priceList": "DEFAULT",
            "eventType": "PHASE",
            "isBlockedBilling": false,
            "isBlockedEntitlement": false,
            "serviceName": "entitlement+billing-service",
            "serviceStateName": "PHASE",
            "phase": "PRD_0000000017_PL_000001-evergreen",
            "auditLogs": [
              {
                "changeType": "INSERT",
                "changeDate": "2017-06-08T00:00:02.000Z",
                "changedBy": "SubscriptionEventQueue",
                "reasonCode": null,
                "comments": null,
                "userToken": "ce3cc5cd-95b6-4a16-a086-15f4148367be"
              }
            ],
            "effectiveDate": "2017-06-07"
          }
        ],
        "auditLogs": [
          {
            "changeType": "INSERT",
            "changeDate": "2017-03-08T00:00:10.000Z",
            "changedBy": "uEngine",
            "reasonCode": null,
            "comments": null,
            "userToken": "bf30a156-5bb5-4a0e-b131-a915f6176151"
          },
          {
            "changeType": "UPDATE",
            "changeDate": "2017-03-08T00:00:12.000Z",
            "changedBy": "SubscriptionBaseTransition",
            "reasonCode": null,
            "comments": null,
            "userToken": "bf30a156-5bb5-4a0e-b131-a915f6176151"
          },
          {
            "changeType": "UPDATE",
            "changeDate": "2017-06-08T00:00:08.000Z",
            "changedBy": "Next Billing Date",
            "reasonCode": null,
            "comments": null,
            "userToken": "eff31a88-d033-4f26-b363-756c91546dfe"
          },
          {
            "changeType": "UPDATE",
            "changeDate": "2017-05-11T00:00:02.000Z",
            "changedBy": "Next Billing Date",
            "reasonCode": null,
            "comments": null,
            "userToken": "52a2454e-723e-4df2-ae8d-0d2e3d9ca374"
          },
          {
            "changeType": "UPDATE",
            "changeDate": "2017-06-16T00:00:06.000Z",
            "changedBy": "SubscriptionBaseTransition",
            "reasonCode": null,
            "comments": null,
            "userToken": "9361cc1a-ffc8-42b0-b40d-990231322c71"
          }
        ]
      },
      "auditLogs": [
        {
          "changeType": "INSERT",
          "changeDate": "2017-03-08T00:00:10.000Z",
          "changedBy": "uEngine",
          "reasonCode": null,
          "comments": null,
          "userToken": "bf30a156-5bb5-4a0e-b131-a915f6176151"
        },
        {
          "changeType": "UPDATE",
          "changeDate": "2017-03-08T00:00:12.000Z",
          "changedBy": "SubscriptionBaseTransition",
          "reasonCode": null,
          "comments": null,
          "userToken": "bf30a156-5bb5-4a0e-b131-a915f6176151"
        },
        {
          "changeType": "UPDATE",
          "changeDate": "2017-06-08T00:00:08.000Z",
          "changedBy": "Next Billing Date",
          "reasonCode": null,
          "comments": null,
          "userToken": "eff31a88-d033-4f26-b363-756c91546dfe"
        },
        {
          "changeType": "UPDATE",
          "changeDate": "2017-05-11T00:00:02.000Z",
          "changedBy": "Next Billing Date",
          "reasonCode": null,
          "comments": null,
          "userToken": "52a2454e-723e-4df2-ae8d-0d2e3d9ca374"
        },
        {
          "changeType": "UPDATE",
          "changeDate": "2017-06-16T00:00:06.000Z",
          "changedBy": "SubscriptionBaseTransition",
          "reasonCode": null,
          "comments": null,
          "userToken": "9361cc1a-ffc8-42b0-b40d-990231322c71"
        }
      ]
    }
  ],
  "invoices": [
    {
      "amount": 0.77,
      "currency": "USD",
      "status": "COMMITTED",
      "creditAdj": 0,
      "refundAdj": 0,
      "invoiceId": "2947c05a-4476-41ba-9da5-a2f5362d2da6",
      "invoiceDate": "2017-06-08",
      "targetDate": "2017-04-10",
      "invoiceNumber": "429",
      "balance": 0,
      "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
      "credits": [],
      "items": null,
      "isParentInvoice": false,
      "auditLogs": [
        {
          "changeType": "INSERT",
          "changeDate": "2017-06-08T00:00:08.000Z",
          "changedBy": "Next Billing Date",
          "reasonCode": null,
          "comments": null,
          "userToken": "eff31a88-d033-4f26-b363-756c91546dfe"
        }
      ],
      "bundleKeys": "55637b45-fb24-4320-8a9c-5b9f5a987c39"
    }
  ],
  "payments": [
    {
      "targetInvoiceId": "17f7e0eb-aefe-4608-b703-e5ec8d9c4023",
      "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
      "paymentId": "2dd73b4f-a911-4fd4-aecc-d7b6157d4dd7",
      "paymentNumber": "295",
      "paymentExternalKey": "911edc2a-2839-419d-a3c3-591f6f7beb9b",
      "authAmount": 0,
      "capturedAmount": 0,
      "purchasedAmount": 17,
      "refundedAmount": 0,
      "creditedAmount": 0,
      "currency": "USD",
      "paymentMethodId": "32cdf8e8-cef1-4995-afcb-ac16eefe7672",
      "transactions": [
        {
          "transactionId": "d48d0e20-75a2-4f03-8d7a-9e5592ce03ca",
          "transactionExternalKey": "6165a7c0-5ba2-49ae-807c-645ef28c9e4f",
          "paymentId": "2dd73b4f-a911-4fd4-aecc-d7b6157d4dd7",
          "paymentExternalKey": "911edc2a-2839-419d-a3c3-591f6f7beb9b",
          "transactionType": "PURCHASE",
          "amount": 17,
          "currency": "USD",
          "effectiveDate": "2017-03-16T09:16:44.000Z",
          "processedAmount": 17,
          "processedCurrency": "USD",
          "status": "SUCCESS",
          "gatewayErrorCode": null,
          "gatewayErrorMsg": "Success",
          "firstPaymentReferenceId": null,
          "secondPaymentReferenceId": null,
          "properties": null,
          "auditLogs": [
            {
              "changeType": "INSERT",
              "changeDate": "2017-03-16T09:16:44.000Z",
              "changedBy": "PaymentRequestProcessor",
              "reasonCode": null,
              "comments": null,
              "userToken": "f28f4bf7-a3aa-4910-8cdb-3b2c0771af0a"
            },
            {
              "changeType": "UPDATE",
              "changeDate": "2017-03-16T09:16:44.000Z",
              "changedBy": "PaymentRequestProcessor",
              "reasonCode": null,
              "comments": null,
              "userToken": "f28f4bf7-a3aa-4910-8cdb-3b2c0771af0a"
            }
          ]
        }
      ],
      "paymentAttempts": null,
      "auditLogs": [
        {
          "changeType": "INSERT",
          "changeDate": "2017-03-16T09:16:44.000Z",
          "changedBy": "PaymentRequestProcessor",
          "reasonCode": null,
          "comments": null,
          "userToken": "f28f4bf7-a3aa-4910-8cdb-3b2c0771af0a"
        },
        {
          "changeType": "UPDATE",
          "changeDate": "2017-03-16T09:16:44.000Z",
          "changedBy": "PaymentRequestProcessor",
          "reasonCode": null,
          "comments": null,
          "userToken": "f28f4bf7-a3aa-4910-8cdb-3b2c0771af0a"
        }
      ]
    }
  ]
}
```

GET /rest/v1/accounts/{accountId}/timeline


### Description
구매자 계정의 모든 타임라인을 조회한다.(구독, 결제, 인보이스 이력)


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**parallel**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[AccountTimelineJson](#accounttimelinejson)|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


### Produces

* `application/json`


<a name="transferchildcredittoparent"></a>
## Move a given child credit to the parent level

```
POST /rest/v1/accounts/{childAccountId}/transferCredit

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/accounts/6e5d149c-5840-4cd8-a8f2-42578c83a099/transferCredit'


Reponse Example

200 no content
```

POST /rest/v1/accounts/{childAccountId}/transferCredit


### Description
구매자 계정의 가상 화폐(Credit) 의 잔액을 부모 계정으로 이동시킨다. (부모 계정이 있을 경우만 해당된다.)


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**childAccountId**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Account does not have credit|No Content|
|**404**|Account not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="deleteaccount"></a>
## Remove account
```
DELETE /rest/v1/accounts/{accountId}

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'Authorization: <token>'  
--header 'X-organization-id: 6925a6d1-a6b7-4298-944b-b29945bd4872' 
'http://localhost:18080/rest/v1/accounts/a4262a82-aae5-40d1-a2d1-ff057618392e'


Reponse Example

204 no content
```


### Description
구매자 계정을 삭제한다. 구독기록이나 결제 기록이 있다면 삭제할 수 없다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**accountId**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|successful operation|No Content|
|**400**|Invalid account delete supplied|No Content|
|**404**|Account not found|No Content|


### Produces

* `application/json`



<a name="updateaccountbcd"></a>
## Update account bcd
```
PUT /rest/v1/accounts/{accountId}/bcd

Request Example

curl -X PUT 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: 6925a6d1-a6b7-4298-944b-b29945bd4872' 
-d '{
  "billCycleDayLocal": 10
}' 'http://localhost:18080/rest/v1/accounts/2fe21dcf-d5ec-4ce2-b55e-922d5e3f4183/bcd'


Response Example

{
  "country": "KR",
  "external_key": "2fe21dcf-d5ec-4ce2-b55e-922d5e3f4183",
  "notes": "",
  "is_notified_for_invoices": false,
  "city": "",
  "is_payment_delegated_to_parent": false,
  "locale": "en_US",
  "state_or_province": "",
  "currency": "USD",
  "id": "2fe21dcf-d5ec-4ce2-b55e-922d5e3f4183",
  "email": "sppark@uengine.org",
  "address1": "",
  "time_zone": "UTC",
  "created_by": "uEngine",
  "record_id": 8,
  "payment_method_id": "15223df2-0441-49bc-af7f-18a20358ba4d",
  "phone": "100000000",
  "company_name": "unionnec",
  "name": "buyer 2",
  "updated_by": "SubscriptionBaseTransition",
  "created_date": 1496509470000,
  "updated_date": 1496509914000,
  "billing_cycle_day_local": 10,
  "postal_code": "",
  "first_name_length": 5,
  "tenant_record_id": 1
}
```


### Description
구매자 계정 결제일을 업데이트 한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**accountId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|[AccountBCDJson](#accountbcdjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[AccountJson](#accountjson)|
|**400**|Invalid account bcd data supplied|No Content|
|**404**|Account Not Found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`



<a name="addaccountunblockingstate"></a>
## Unblock an account
```
PUT /rest/v1/accounts/{accountId}/unblock

Request Example

curl -X PUT 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: 6925a6d1-a6b7-4298-944b-b29945bd4872' 
'http://localhost:18080/rest/v1/accounts/2fe21dcf-d5ec-4ce2-b55e-922d5e3f4183/unblock?resumeInvoice=true'


Response Example

200 OK
```


### Description
구매자 계정을 UnBlock 시킨다.


### Parameters

|Type|Name|Description|Schema|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*||string|
|**Query**|**resumeInvoice**  <br>*optional*|인보이스 생성 재시작 여부|boolean|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|No Content|
|**400**|Invalid account unblock supplied|No Content|
|**404**|Account not found|No Content|


### Consumes

* `application/json`




<a name="getaccountonetimebuy"></a>
## Retrieve onetimebuy for account
```
GET /rest/v1/accounts/{accountId}/onetimebuy

Request Example

curl -X GET -
-header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: 6925a6d1-a6b7-4298-944b-b29945bd4872' 
'http://localhost:18080/rest/v1/accounts/2fe21dcf-d5ec-4ce2-b55e-922d5e3f4183/onetimebuy'


Response Example

[
  {
    "record_id": 49,
    "bundle_id": "87c85f88-bcf0-4057-acf5-638ad4b0abd8",
    "state": "PENDING_INVOICE",
    "tenant_id": "a31a66e0-ed86-494c-983a-75df5894069d",
    "organization_id": "6925a6d1-a6b7-4298-944b-b29945bd4872",
    "account_id": "2fe21dcf-d5ec-4ce2-b55e-922d5e3f4183",
    "product_id": "PRD_0000000006",
    "version": 2,
    "plan_name": "PRD_0000000006_PL_000001",
    "plan_display_name": "일회 결제 샘플 1번",
    "amount": 10,
    "currency": "USD",
    "invoice_id": null,
    "invoice_item_id": null,
    "effective_date": "2017-06-30",
    "billing_date": "2018-01-04",
    "created_date": "2017-06-30"
  }
]
```


### Description
구매자 계정이 구매한 일회성 구매 이력을 조회한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**accountId**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [OneTimeBuyJson](#onetimebuyjson) > array|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


### Produces

* `application/json`





<a name="getaccountsalesbalance"></a>
## get account sales balance
```
GET /rest/v1/accounts/{accountId}/sales/balance

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: 6925a6d1-a6b7-4298-944b-b29945bd4872' 
'http://localhost:18080/rest/v1/accounts/881c5072-5a7d-4b35-8ade-25939da579e3/sales/balance'


Response Example

{
  "balance": {
    "KRW": 12915.8,
    "USD": 70.514419
  },
  "credit": {},
  "sales": {
    "KRW": 13735.8,
    "USD": 83.907619
  },
  "refund": {
    "KRW": -820,
    "USD": -2.3932
  },
  "withdraw": {
    "USD": -11
  }
}
```


### Description
구매자 계정의 판매대금 잔액을 조회한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**accountId**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[AccountSalesBalanceJson](#accountsalesbalancejson)|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


### Produces

* `application/json`


<a name="cancelwithdraw"></a>
## Cancel withdraw
```
DELETE /rest/v1/accounts/{accountId}/sales/cancelwithdraw/{sales_record_id}

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
'http://localhost:18080/rest/v1/accounts/881c5072-5a7d-4b35-8ade-25939da579e3/sales/cancelwithdraw/501'


Response Example

200 OK
```


### Description
판매자의 판매 잔금을 출금기록을 취소한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**accountId**  <br>*required*|string|
|**Path**|**sales_record_id**  <br>*required*|number|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|No Content|
|**400**|Invalid Request|No Content|
|**404**|Not found sales record|No Content|


### Produces

* `application/json`


<a name="getaccountssales"></a>
## List accounts sales history
```
GET /rest/v1/accounts/{accountId}/sales/pagination

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: 6925a6d1-a6b7-4298-944b-b29945bd4872' 
'http://localhost:18080/rest/v1/accounts/881c5072-5a7d-4b35-8ade-25939da579e3/sales/pagination?offset=0&limit=1'


Response Example

[
  {
    "record_id": 256,
    "subscription_id": "49c5c928-110f-461f-93f0-2d82a7d27a51",
    "tenant_id": "a31a66e0-ed86-494c-983a-75df5894069d",
    "organization_id": "6925a6d1-a6b7-4298-944b-b29945bd4872",
    "buyer_id": "2fe21dcf-d5ec-4ce2-b55e-922d5e3f4183",
    "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3",
    "product_id": "PRD_0000000002",
    "version": 1,
    "plan_name": "PRD_0000000002_PL_000001",
    "usage_name": null,
    "ratio": 30,
    "amount": 1.5,
    "original_amount": 5,
    "currency": "USD",
    "invoice_id": "08363881-445e-4431-aa1e-9838b95defbd",
    "invoice_item_id": "63f5363f-3d4c-45f8-a5ee-4c025f04a382",
    "linked_invoice_item_id": null,
    "invoice_item_type": "RECURRING",
    "price_type": "RECURRING",
    "transaction_type": "CREATION",
    "format_date": "2017-12-20",
    "created_date": "2017-06-30",
    "notes": "Bds"
  }
]
```


### Description
판매자의 판매 이력을 페이징 처리하여 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [ProductDistributionHistory](#productdistributionhistory) > array|


### Produces

* `application/json`


<a name="searchaccountssales"></a>
## Search accounts sales history
```
GET /rest/v1/accounts/{accountId}/sales/search/{searchKey}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: 6925a6d1-a6b7-4298-944b-b29945bd4872' 
'http://localhost:18080/rest/v1/accounts/881c5072-5a7d-4b35-8ade-25939da579e3/sales/search/PRD_0000000002_PL_000001?offset=0&limit=1'


Response Example

[
  {
    "record_id": 256,
    "subscription_id": "49c5c928-110f-461f-93f0-2d82a7d27a51",
    "tenant_id": "a31a66e0-ed86-494c-983a-75df5894069d",
    "organization_id": "6925a6d1-a6b7-4298-944b-b29945bd4872",
    "buyer_id": "2fe21dcf-d5ec-4ce2-b55e-922d5e3f4183",
    "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3",
    "product_id": "PRD_0000000002",
    "version": 1,
    "plan_name": "PRD_0000000002_PL_000001",
    "usage_name": null,
    "ratio": 30,
    "amount": 1.5,
    "original_amount": 5,
    "currency": "USD",
    "invoice_id": "08363881-445e-4431-aa1e-9838b95defbd",
    "invoice_item_id": "63f5363f-3d4c-45f8-a5ee-4c025f04a382",
    "linked_invoice_item_id": null,
    "invoice_item_type": "RECURRING",
    "price_type": "RECURRING",
    "transaction_type": "CREATION",
    "format_date": "2017-12-20",
    "created_date": "2017-06-30",
    "notes": "Bds"
  }
]
```


### Description
주어진 검색어에 해당하는 판매자 계정의 판매 이력을 페이징 처리하여 반환한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Path**|**searchKey**  <br>*required*|string||
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [ProductDistributionHistory](#productdistributionhistory) > array|


### Produces

* `application/json`


<a name="getaccountsalessummary"></a>
## get account sales summary per date
```
GET /rest/v1/accounts/{accountId}/sales/summary

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: 6925a6d1-a6b7-4298-944b-b29945bd4872' 
'http://localhost:18080/rest/v1/accounts/881c5072-5a7d-4b35-8ade-25939da579e3/sales/summary?period=MONTH&start_date=2017-01-01&end_date=2017-12-31'


Response Example

{
  "refund": {
    "summary": {
      "total": {
        "USD": -2.3932,
        "KRW": -820
      },
      "per_usage_name": {
        "PRD_0000000001_USG_000001": {
          "USD": -0.332,
          "KRW": -99.6
        }
      },
      "per_vendor_id": {
        "881c5072-5a7d-4b35-8ade-25939da579e3": {
          "USD": -2.3932,
          "KRW": -820
        }
      },
      "per_product_id": {
        "PRD_0000000002": {
          "USD": -1.2,
          "KRW": -600
        },
        "PRD_0000000001": {
          "USD": -0.6932,
          "KRW": -220
        },
        "PRD_0000000006": {
          "USD": -0.5
        }
      },
      "per_plan_name": {
        "PRD_0000000006_PL_000001": {
          "USD": -0.5
        },
        "PRD_0000000001_PL_000001": {
          "USD": -0.6932,
          "KRW": -220
        },
        "PRD_0000000002_PL_000001": {
          "USD": -1.2,
          "KRW": -600
        }
      },
      "per_price_type": {
        "USAGE": {
          "USD": -0.332,
          "KRW": -99.6
        },
        "RECURRING": {
          "USD": -1.5612,
          "KRW": -720.4
        },
        "ONE_TIME": {
          "USD": -0.5
        }
      }
    },
    "per_date": {
      "2017-06": [
        {
          "usage_name": "",
          "amount": {
            "USD": -0.5
          },
          "price_type": "ONE_TIME",
          "plan_name": "PRD_0000000006_PL_000001",
          "product_id": "PRD_0000000006",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        }
      ],
      "2017-08": [
        {
          "usage_name": "",
          "amount": {
            "USD": -0.3612,
            "KRW": -120.4
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "PRD_0000000001_USG_000001",
          "amount": {
            "USD": -0.332,
            "KRW": -99.6
          },
          "price_type": "USAGE",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": -1.2,
            "KRW": -600
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000002_PL_000001",
          "product_id": "PRD_0000000002",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        }
      ]
    }
  },
  "credit": {
    "summary": {
      "total": {},
      "per_usage_name": {},
      "per_vendor_id": {},
      "per_product_id": {},
      "per_plan_name": {},
      "per_price_type": {}
    },
    "per_date": {}
  },
  "end_date": "2017-12-31",
  "withdraw": {
    "summary": {
      "total": {
        "USD": -11
      },
      "per_usage_name": {},
      "per_vendor_id": {
        "881c5072-5a7d-4b35-8ade-25939da579e3": {
          "USD": -11
        }
      },
      "per_product_id": {},
      "per_plan_name": {},
      "per_price_type": {}
    },
    "per_date": {
      "2017-07": [
        {
          "usage_name": "",
          "amount": {
            "USD": -11
          },
          "price_type": "",
          "plan_name": "",
          "product_id": "",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        }
      ]
    }
  },
  "sales": {
    "summary": {
      "total": {
        "USD": 83.907619,
        "KRW": 13735.8
      },
      "per_usage_name": {
        "PRD_0000000001_USG_000001": {
          "USD": 1.5272,
          "KRW": 1128.8
        }
      },
      "per_vendor_id": {
        "881c5072-5a7d-4b35-8ade-25939da579e3": {
          "USD": 83.907619,
          "KRW": 13735.8
        }
      },
      "per_product_id": {
        "PRD_0000000002": {
          "USD": 51.936,
          "KRW": 10500
        },
        "PRD_0000000001": {
          "USD": 27.471619,
          "KRW": 3235.8
        },
        "PRD_0000000006": {
          "USD": 4.5
        }
      },
      "per_plan_name": {
        "PRD_0000000006_PL_000001": {
          "USD": 4.5
        },
        "PRD_0000000001_PL_000002": {
          "USD": 1.95
        },
        "PRD_0000000001_PL_000003": {
          "USD": 2.4195
        },
        "PRD_0000000001_PL_000001": {
          "USD": 23.102119,
          "KRW": 3235.8
        },
        "PRD_0000000002_PL_000001": {
          "USD": 51.936,
          "KRW": 10500
        }
      },
      "per_price_type": {
        "USAGE": {
          "USD": 1.5272,
          "KRW": 1128.8
        },
        "RECURRING": {
          "USD": 77.329419,
          "KRW": 12607
        },
        "ONE_TIME": {
          "USD": 4.5
        },
        "FIXED": {
          "USD": 0.551
        }
      }
    },
    "per_date": {
      "2017-06": [
        {
          "usage_name": "",
          "amount": {
            "USD": 3.5518,
            "KRW": 301
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 4.299,
            "KRW": 1500
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000002_PL_000001",
          "product_id": "PRD_0000000002",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 0
          },
          "price_type": "FIXED",
          "plan_name": "PRD_0000000001_PL_000003",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 1
          },
          "price_type": "ONE_TIME",
          "plan_name": "PRD_0000000006_PL_000001",
          "product_id": "PRD_0000000006",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        }
      ],
      "2017-10": [
        {
          "usage_name": "",
          "amount": {
            "USD": 1.403,
            "KRW": 301
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 0.301
          },
          "price_type": "FIXED",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 0.65
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000002",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 3,
            "KRW": 1500
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000002_PL_000001",
          "product_id": "PRD_0000000002",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        }
      ],
      "2017-11": [
        {
          "usage_name": "",
          "amount": {
            "USD": 1.102,
            "KRW": 301
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 0.65
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000002",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 3,
            "KRW": 1500
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000002_PL_000001",
          "product_id": "PRD_0000000002",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        }
      ],
      "2017-12": [
        {
          "usage_name": "",
          "amount": {
            "USD": 2.607,
            "KRW": 301
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 0.65
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000002",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 3,
            "KRW": 1500
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000002_PL_000001",
          "product_id": "PRD_0000000002",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        }
      ],
      "2017-07": [
        {
          "usage_name": "",
          "amount": {
            "USD": 0.25
          },
          "price_type": "FIXED",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 4.922933
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 17.685
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000002_PL_000001",
          "product_id": "PRD_0000000002",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 0.5
          },
          "price_type": "ONE_TIME",
          "plan_name": "PRD_0000000006_PL_000001",
          "product_id": "PRD_0000000006",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        }
      ],
      "2017-08": [
        {
          "usage_name": "",
          "amount": {
            "USD": 1.9195
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000003",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 4.549052,
            "KRW": 602
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "PRD_0000000001_USG_000001",
          "amount": {
            "USD": 1.5272,
            "KRW": 1128.8
          },
          "price_type": "USAGE",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 14.952,
            "KRW": 3000
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000002_PL_000001",
          "product_id": "PRD_0000000002",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 1.5
          },
          "price_type": "ONE_TIME",
          "plan_name": "PRD_0000000006_PL_000001",
          "product_id": "PRD_0000000006",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        }
      ],
      "2017-09": [
        {
          "usage_name": "",
          "amount": {
            "USD": 2.888134,
            "KRW": 301
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 0.5
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000003",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 6,
            "KRW": 1500
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000002_PL_000001",
          "product_id": "PRD_0000000002",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 1.5
          },
          "price_type": "ONE_TIME",
          "plan_name": "PRD_0000000006_PL_000001",
          "product_id": "PRD_0000000006",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        }
      ]
    }
  },
  "start_date": "2017-01-01",
  "currencies": [
    "KRW",
    "USD"
  ]
}
```


### Description
구매자 계정의 판매대금 합계를 기간별로 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**end_date**  <br>*optional*|string||
|**Query**|**period**  <br>*optional*|enum (DAY, MONTH, YEAR)|`"DAY"`|
|**Query**|**plan_name**  <br>*optional*|string||
|**Query**|**product_id**  <br>*optional*|string||
|**Query**|**start_date**  <br>*optional*|string||
|**Query**|**usage_name**  <br>*optional*|string||


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[SalesPerDateSummaryJson](#salesperdatesummaryjson)|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


### Produces

* `application/json`


<a name="withdrawaccountssales"></a>
## Withdraw accounts sales
```
POST /rest/v1/accounts/{accountId}/sales/withdraw

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: 6925a6d1-a6b7-4298-944b-b29945bd4872' 
-d '{
  "transactionType": "WITHDRAW", /"CREDIT"
  "amount": 10,
  "currency": "USD",
  "notes": "출금 기록1"
}' 'http://localhost:18080/rest/v1/accounts/881c5072-5a7d-4b35-8ade-25939da579e3/sales/withdraw'


Response Example

{
  "record_id": 501,
  "subscription_id": null,
  "tenant_id": "a31a66e0-ed86-494c-983a-75df5894069d",
  "organization_id": "6925a6d1-a6b7-4298-944b-b29945bd4872",
  "buyer_id": null,
  "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3",
  "product_id": null,
  "version": null,
  "plan_name": null,
  "usage_name": null,
  "ratio": null,
  "amount": -10,
  "original_amount": null,
  "currency": "USD",
  "invoice_id": null,
  "invoice_item_id": null,
  "linked_invoice_item_id": null,
  "invoice_item_type": null,
  "price_type": null,
  "transaction_type": "WITHDRAW",
  "format_date": "2017-07-10",
  "created_date": "2017-07-10",
  "notes": "출금 기록1"
}
```


### Description
판매자의 판매 잔금을 출금처리한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**accountId**  <br>*required*|string|
|**Body**|**body**  <br>*required*|[SalesWithdrawRequest](#saleswithdrawrequest)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|successful operation|< [ProductDistributionHistory](#productdistributionhistory) > array|
|**400**|Invalid Request|No Content|
|**404**|Not found account|No Content|


### Produces

* `application/json`



<a name="auth_resource"></a>
# Auth

<a name="accesstoken"></a>
## Login and get token

```
POST /rest/v1/access_token

Request Example

curl -X POST 
--header 'Content-Type: application/x-www-form-urlencoded' 
--header 'Accept: application/json' 
'http://localhost:18080/rest/v1/access_token?username=sppark2&password=gosu23546&scope=uEngineSubscriptions%2Fsubscriptionsapi'


Reponse Example

{
  "expires_in": 36000,
  "token_type": "JWT",
  "refresh_token": "6fc1fe0a-6fcc-4b3b-8a7b-7d09701b8648",
  "access_token": "eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0OTAzMDI0MDQsImNvbnRleHQiOnsic2NvcGVzIjoidUVuZ2luZVN1YnNjcmlwdGlvbnNcL3N1YnNjcmlwdGlvbnNhcGkiLCJ1c2VySWQiOiIxYTBiOTA5NTk3YzU0NjRiYjllN2FiMWMzYWVjMzFlNiIsImNsaWVudEtleSI6ImU3NGE5NTA1LWE4MTEtNDA3Zi1iNGY2LTEyOWI3YWYxYzcwMyIsInVzZXJOYW1lIjoic3BwYXJrMiIsIm1hbmFnZW1lbnRJZCI6ImRkZmVmZWMwNzg5YjRkYmZiMDBjNzI1NjExYmI2OTVlIiwicmVmcmVzaFRva2VuIjoiNmZjMWZlMGEtNmZjYy00YjNiLThhN2ItN2QwOTcwMWI4NjQ4IiwidHlwZSI6InVzZXIiLCJjbGllbnRJZCI6IjJjZWU5MDIzMTYzMjRjZDRiYjJkOTY0ODczOTAxZWViIn0sImlzcyI6Im9jZS5pYW0iLCJjbGFpbSI6e30sImlhdCI6MTQ5MDI2NjQwNH0.xBhMGlry2XtXouWnaPQ4aDyhbzym_0VvzF1guOixQqc",
  "status": 200
}
```

POST /rest/v1/access_token


### Description
로그인 하여 토큰을 받아온다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Query**|**password**  <br>*required*|string|
|**Query**|**scope**  <br>*required*|string|
|**Query**|**username**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TokenJson](#tokenjson)|
|**400**|Invalid user information|No Content|


### Consumes

* `application/x-www-form-urlencoded`


### Produces

* `application/json`


<a name="tokeninfo"></a>
## Validate token

```
GET /rest/v1/token_info

Request Example

curl -X GET 
--header 'Accept: application/json' 
'http://localhost:18080/rest/v1/token_info?authorization=<token>'



Reponse Example

{
  "level": 0,
  "docType": "oauth_user",
  "enable": true,
  "managementId": "ddfefec0789b4dbfb00c725611bb695e",
  "_rev": "2-34e104faed3601819f03ebcfdaa5346f",
  "regDate": 1486959644923,
  "_id": "1a0b909597c5464bb9e7ab1c3aec31e6",
  "userName": "sppark2",
  "email": "darkgodarkgo@gmail.com",
  "updDate": 1486959678856
}
```

GET /rest/v1/token_info


### Description
토큰이 유효한지 체크한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Query**|**authorization**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[UserJson](#userjson)|
|**400**|Invalid token|No Content|


### Produces

* `application/json`


<a name="onetimebuy_resource"></a>
# Onetimebuy

<a name="createonetimebuy"></a>
## Create Onetimebuy
```
POST /rest/v1/onetimebuy

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: 6925a6d1-a6b7-4298-944b-b29945bd4872' 
-d '[
  {
    "bundleId": "112b255c-5055-459b-861f-f2b53d063f75",
    "productCategory": "ONE_TIME",
    "planName": "PRD_0000000006_PL_000001"
  }
]' 'http://localhost:18080/rest/v1/onetimebuy?accountId=881c5072-5a7d-4b35-8ade-25939da579e3&requestedDate=2017-07-10'

* 번들에 포함하여 구매하지 않고 개별 구매를 할 경우는 bundleId 값을 주지 않습니다.
* requestedDate 를 지정하지 않은 경우 오늘 날짜로 구매됩니다.


Response Example

[
  {
    "record_id": 52,
    "bundle_id": "112b255c-5055-459b-861f-f2b53d063f75",
    "state": "PENDING_INVOICE",
    "tenant_id": "a31a66e0-ed86-494c-983a-75df5894069d",
    "organization_id": "6925a6d1-a6b7-4298-944b-b29945bd4872",
    "account_id": "881c5072-5a7d-4b35-8ade-25939da579e3",
    "product_id": "PRD_0000000006",
    "version": 2,
    "plan_name": "PRD_0000000006_PL_000001",
    "plan_display_name": "일회 결제 샘플 1번",
    "amount": 10,
    "currency": "USD",
    "invoice_id": null,
    "invoice_item_id": null,
    "effective_date": "2017-07-10",
    "billing_date": "2017-08-10",
    "created_date": "2017-07-10"
  }
]
```


### Description
일회성 구매들을 요청한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Query**|**accountId**  <br>*optional*|string|
|**Query**|**requestedDate**  <br>*optional*|string|
|**Body**|**body**  <br>*required*|[ListOneTimeBuyRequestJson](#listonetimebuyrequestjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|successful operation|< [OneTimeBuyJson](#onetimebuyjson) > array|
|**400**|Invalid Request|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="listonetimebuys"></a>
## List onetimebuy
```
GET /rest/v1/onetimebuy/pagination

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: 6925a6d1-a6b7-4298-944b-b29945bd4872' 
'http://localhost:18080/rest/v1/onetimebuy/pagination?offset=0&limit=1'


Response Example

[
  {
    "record_id": 25,
    "bundle_id": "d681ce0a-8c5e-451e-9c02-4601cda7cf02",
    "state": "INVOICED",
    "tenant_id": "a31a66e0-ed86-494c-983a-75df5894069d",
    "organization_id": "6925a6d1-a6b7-4298-944b-b29945bd4872",
    "account_id": "88f53eb4-3f8b-41a2-8a07-5e06e6633548",
    "product_id": "PRD_0000000006",
    "version": 2,
    "plan_name": "PRD_0000000006_PL_000001",
    "plan_display_name": "일회 결제 샘플 1번",
    "amount": 10,
    "currency": "USD",
    "invoice_id": "790b4479-d737-4070-a0ef-076764707cd7",
    "invoice_item_id": "ab195cfa-63a9-4b76-a4ef-b45b6ea4ffd8",
    "effective_date": "2017-08-01",
    "billing_date": "2017-09-06",
    "created_date": "2017-06-15"
  }
]
```


### Description
onetimebuy 를 페이징 하여 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [OneTimeBuyJson](#onetimebuyjson) > array|
|**204**|No Content|No Content|
|**400**|Invalid Request|No Content|


### Produces

* `application/json`


<a name="searchonetimebuy"></a>
## Search onetimebuys
```
GET /rest/v1/onetimebuy/search/{searchKey}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: 6925a6d1-a6b7-4298-944b-b29945bd4872' 
'http://localhost:18080/rest/v1/onetimebuy/search/PRD_0000000006_PL_000001?offset=0&limit=1'


Response Example

[
  {
    "record_id": 25,
    "bundle_id": "d681ce0a-8c5e-451e-9c02-4601cda7cf02",
    "state": "INVOICED",
    "tenant_id": "a31a66e0-ed86-494c-983a-75df5894069d",
    "organization_id": "6925a6d1-a6b7-4298-944b-b29945bd4872",
    "account_id": "88f53eb4-3f8b-41a2-8a07-5e06e6633548",
    "product_id": "PRD_0000000006",
    "version": 2,
    "plan_name": "PRD_0000000006_PL_000001",
    "plan_display_name": "일회 결제 샘플 1번",
    "amount": 10,
    "currency": "USD",
    "invoice_id": "790b4479-d737-4070-a0ef-076764707cd7",
    "invoice_item_id": "ab195cfa-63a9-4b76-a4ef-b45b6ea4ffd8",
    "effective_date": "2017-08-01",
    "billing_date": "2017-09-06",
    "created_date": "2017-06-15"
  }
]
```


### Description
주어진 검색어에 해당하는 onetimebuy 들을 페이징 처리하여 반환한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**searchKey**  <br>*required*|string||
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [OneTimeBuyJson](#onetimebuyjson) > array|
|**204**|No Content|No Content|
|**400**|Invalid Request|No Content|


### Produces

* `application/json`


<a name="getonetimebuy"></a>
## Retrieve an onetimebuy by id
```
GET /rest/v1/onetimebuy/{record_id}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: 6925a6d1-a6b7-4298-944b-b29945bd4872' 
'http://localhost:18080/rest/v1/onetimebuy/52'


Response Example

{
  "record_id": 52,
  "bundle_id": "112b255c-5055-459b-861f-f2b53d063f75",
  "state": "PENDING_INVOICE",
  "tenant_id": "a31a66e0-ed86-494c-983a-75df5894069d",
  "organization_id": "6925a6d1-a6b7-4298-944b-b29945bd4872",
  "account_id": "881c5072-5a7d-4b35-8ade-25939da579e3",
  "product_id": "PRD_0000000006",
  "version": 2,
  "plan_name": "PRD_0000000006_PL_000001",
  "plan_display_name": "일회 결제 샘플 1번",
  "amount": 10,
  "currency": "USD",
  "invoice_id": null,
  "invoice_item_id": null,
  "effective_date": "2017-07-10",
  "billing_date": "2017-08-10",
  "created_date": "2017-07-10"
}
```


### Description
onetimebuy 를 아이디로 조회한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**record_id**  <br>*required*|number|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[OneTimeBuyJson](#onetimebuyjson)|
|**400**|Invalid onetimebuy id supplied|No Content|
|**404**|onetimebuy not found|No Content|


### Produces

* `application/json`


<a name="cancelonetimebuy"></a>
## Cancel Onetimebuy
```
DELETE /rest/v1/onetimebuy/{record_id}

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: 6925a6d1-a6b7-4298-944b-b29945bd4872' 
'http://localhost:18080/rest/v1/onetimebuy/52'


Response Example

{
  "record_id": 52,
  "bundle_id": "112b255c-5055-459b-861f-f2b53d063f75",
  "state": "CANCELED",
  "tenant_id": "a31a66e0-ed86-494c-983a-75df5894069d",
  "organization_id": "6925a6d1-a6b7-4298-944b-b29945bd4872",
  "account_id": "881c5072-5a7d-4b35-8ade-25939da579e3",
  "product_id": "PRD_0000000006",
  "version": 2,
  "plan_name": "PRD_0000000006_PL_000001",
  "plan_display_name": "일회 결제 샘플 1번",
  "amount": 10,
  "currency": "USD",
  "invoice_id": null,
  "invoice_item_id": null,
  "effective_date": "2017-07-10",
  "billing_date": "2017-08-10",
  "created_date": "2017-07-10"
}
```


### Description
Onetimebuy 요청을 취소한다. 결제 대기(PENDING_INVOICE) 상태인 것만 가능하다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**record_id**  <br>*required*|number|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[OneTimeBuyJson](#onetimebuyjson)|
|**400**|Invalid onetimebuy id supplied|No Content|
|**404**|onetimebuy not found|No Content|


### Produces

* `application/json`


<a name="bundles_resource"></a>
# Bundles

<a name="getbundlebykey"></a>
## Retrieve a bundle by external key

```
GET /rest/v1/bundles

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/bundles?externalKey=55637b45-fb24-4320-8a9c-5b9f5a987c39&includedDeleted=false&audit=NONE'


Reponse Example

{
  "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
  "bundleId": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
  "externalKey": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
  "subscriptions": [
    {
      "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
      "bundleId": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
      "subscriptionId": "05ed0ff5-d655-4825-aba6-f8885aeb98d2",
      "externalKey": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
      "startDate": "2017-03-08",
      "productName": "PRD_0000000017",
      "productCategory": "BASE",
      "billingPeriod": "MONTHLY",
      "phaseType": "TRIAL",
      "priceList": "DEFAULT",
      "planName": "PRD_0000000017_PL_000001",
      "state": "ACTIVE",
      "sourceType": "NATIVE",
      "cancelledDate": null,
      "chargedThroughDate": "2017-06-10",
      "billingStartDate": "2017-03-08",
      "billingEndDate": null,
      "billCycleDayLocal": 10,
      "events": [
        {
          "eventId": "5f604100-138f-41e7-a14c-b9527c0476b0",
          "billingPeriod": "MONTHLY",
          "product": "PRD_0000000017",
          "priceList": "DEFAULT",
          "eventType": "START_ENTITLEMENT",
          "isBlockedBilling": false,
          "isBlockedEntitlement": false,
          "serviceName": "entitlement-service",
          "serviceStateName": "ENT_STARTED",
          "phase": "PRD_0000000017_PL_000001-discount",
          "auditLogs": [],
          "effectiveDate": "2017-03-08"
        },
        {
          "eventId": "adad42eb-24f1-4e03-8270-b5bbe8fe8c9c",
          "billingPeriod": "MONTHLY",
          "product": "PRD_0000000017",
          "priceList": "DEFAULT",
          "eventType": "START_BILLING",
          "isBlockedBilling": false,
          "isBlockedEntitlement": false,
          "serviceName": "billing-service",
          "serviceStateName": "START_BILLING",
          "phase": "PRD_0000000017_PL_000001-trial",
          "auditLogs": [],
          "effectiveDate": "2017-03-08"
        },
        {
          "eventId": "797a4f9b-eb9d-4552-b31e-1253d58c7879",
          "billingPeriod": "MONTHLY",
          "product": "PRD_0000000017",
          "priceList": "DEFAULT",
          "eventType": "SERVICE_STATE_CHANGE",
          "isBlockedBilling": false,
          "isBlockedEntitlement": false,
          "serviceName": "aaa",
          "serviceStateName": "bbb",
          "phase": "PRD_0000000017_PL_000001-discount",
          "auditLogs": [],
          "effectiveDate": "2017-03-23"
        },
        {
          "eventId": "801c5a59-5f3d-475d-86f3-0022be068d86",
          "billingPeriod": "MONTHLY",
          "product": "PRD_0000000017",
          "priceList": "DEFAULT",
          "eventType": "PHASE",
          "isBlockedBilling": false,
          "isBlockedEntitlement": false,
          "serviceName": "entitlement+billing-service",
          "serviceStateName": "PHASE",
          "phase": "PRD_0000000017_PL_000001-discount",
          "auditLogs": [],
          "effectiveDate": "2017-04-07"
        },
        {
          "eventId": "f4471316-9717-4910-96e9-89680388c94e",
          "billingPeriod": "MONTHLY",
          "product": "PRD_0000000017",
          "priceList": "DEFAULT",
          "eventType": "PHASE",
          "isBlockedBilling": false,
          "isBlockedEntitlement": false,
          "serviceName": "entitlement+billing-service",
          "serviceStateName": "PHASE",
          "phase": "PRD_0000000017_PL_000001-evergreen",
          "auditLogs": [],
          "effectiveDate": "2017-06-07"
        }
      ],
      "priceOverrides": [
        {
          "phaseName": "PRD_0000000017_PL_000001-trial",
          "phaseType": "TRIAL",
          "fixedPrice": 0,
          "recurringPrice": null
        },
        {
          "phaseName": "PRD_0000000017_PL_000001-discount",
          "phaseType": "DISCOUNT",
          "fixedPrice": null,
          "recurringPrice": 8
        },
        {
          "phaseName": "PRD_0000000017_PL_000001-evergreen",
          "phaseType": "EVERGREEN",
          "fixedPrice": null,
          "recurringPrice": 10
        }
      ],
      "auditLogs": []
    }
  ],
  "timeline": {
    "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "bundleId": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
    "externalKey": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
    "events": [
      {
        "eventId": "5f604100-138f-41e7-a14c-b9527c0476b0",
        "billingPeriod": "MONTHLY",
        "product": "PRD_0000000017",
        "priceList": "DEFAULT",
        "eventType": "START_ENTITLEMENT",
        "isBlockedBilling": false,
        "isBlockedEntitlement": false,
        "serviceName": "entitlement-service",
        "serviceStateName": "ENT_STARTED",
        "phase": "PRD_0000000017_PL_000001-discount",
        "auditLogs": [],
        "effectiveDate": "2017-03-08"
      },
      {
        "eventId": "adad42eb-24f1-4e03-8270-b5bbe8fe8c9c",
        "billingPeriod": "MONTHLY",
        "product": "PRD_0000000017",
        "priceList": "DEFAULT",
        "eventType": "START_BILLING",
        "isBlockedBilling": false,
        "isBlockedEntitlement": false,
        "serviceName": "billing-service",
        "serviceStateName": "START_BILLING",
        "phase": "PRD_0000000017_PL_000001-trial",
        "auditLogs": [],
        "effectiveDate": "2017-03-08"
      },
      {
        "eventId": "797a4f9b-eb9d-4552-b31e-1253d58c7879",
        "billingPeriod": "MONTHLY",
        "product": "PRD_0000000017",
        "priceList": "DEFAULT",
        "eventType": "SERVICE_STATE_CHANGE",
        "isBlockedBilling": false,
        "isBlockedEntitlement": false,
        "serviceName": "aaa",
        "serviceStateName": "bbb",
        "phase": "PRD_0000000017_PL_000001-discount",
        "auditLogs": [],
        "effectiveDate": "2017-03-23"
      },
      {
        "eventId": "801c5a59-5f3d-475d-86f3-0022be068d86",
        "billingPeriod": "MONTHLY",
        "product": "PRD_0000000017",
        "priceList": "DEFAULT",
        "eventType": "PHASE",
        "isBlockedBilling": false,
        "isBlockedEntitlement": false,
        "serviceName": "entitlement+billing-service",
        "serviceStateName": "PHASE",
        "phase": "PRD_0000000017_PL_000001-discount",
        "auditLogs": [],
        "effectiveDate": "2017-04-07"
      },
      {
        "eventId": "f4471316-9717-4910-96e9-89680388c94e",
        "billingPeriod": "MONTHLY",
        "product": "PRD_0000000017",
        "priceList": "DEFAULT",
        "eventType": "PHASE",
        "isBlockedBilling": false,
        "isBlockedEntitlement": false,
        "serviceName": "entitlement+billing-service",
        "serviceStateName": "PHASE",
        "phase": "PRD_0000000017_PL_000001-evergreen",
        "auditLogs": [],
        "effectiveDate": "2017-06-07"
      }
    ],
    "auditLogs": []
  },
  "auditLogs": []
}
```

GET /rest/v1/bundles


### Description
주어진 external key 로 번들 한건을 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**externalKey**  <br>*optional*|string||
|**Query**|**includedDeleted**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[BundleJson](#bundlejson)|
|**404**|Bundle not found|No Content|


### Produces

* `application/json`


<a name="getbundles"></a>
## List bundles

```
GET /rest/v1/bundles/pagination

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/bundles/pagination?offset=0&limit=100&audit=NONE'


Reponse Example

[
	{
	  "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
	  "bundleId": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
	  "externalKey": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
	  "subscriptions": [
	    {
	      "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
	      "bundleId": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
	      "subscriptionId": "05ed0ff5-d655-4825-aba6-f8885aeb98d2",
	      "externalKey": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
	      "startDate": "2017-03-08",
	      "productName": "PRD_0000000017",
	      "productCategory": "BASE",
	      "billingPeriod": "MONTHLY",
	      "phaseType": "TRIAL",
	      "priceList": "DEFAULT",
	      "planName": "PRD_0000000017_PL_000001",
	      "state": "ACTIVE",
	      "sourceType": "NATIVE",
	      "cancelledDate": null,
	      "chargedThroughDate": "2017-06-10",
	      "billingStartDate": "2017-03-08",
	      "billingEndDate": null,
	      "billCycleDayLocal": 10,
	      "events": [
	        {
	          "eventId": "5f604100-138f-41e7-a14c-b9527c0476b0",
	          "billingPeriod": "MONTHLY",
	          "product": "PRD_0000000017",
	          "priceList": "DEFAULT",
	          "eventType": "START_ENTITLEMENT",
	          "isBlockedBilling": false,
	          "isBlockedEntitlement": false,
	          "serviceName": "entitlement-service",
	          "serviceStateName": "ENT_STARTED",
	          "phase": "PRD_0000000017_PL_000001-discount",
	          "auditLogs": [],
	          "effectiveDate": "2017-03-08"
	        },
	        {
	          "eventId": "adad42eb-24f1-4e03-8270-b5bbe8fe8c9c",
	          "billingPeriod": "MONTHLY",
	          "product": "PRD_0000000017",
	          "priceList": "DEFAULT",
	          "eventType": "START_BILLING",
	          "isBlockedBilling": false,
	          "isBlockedEntitlement": false,
	          "serviceName": "billing-service",
	          "serviceStateName": "START_BILLING",
	          "phase": "PRD_0000000017_PL_000001-trial",
	          "auditLogs": [],
	          "effectiveDate": "2017-03-08"
	        },
	        {
	          "eventId": "797a4f9b-eb9d-4552-b31e-1253d58c7879",
	          "billingPeriod": "MONTHLY",
	          "product": "PRD_0000000017",
	          "priceList": "DEFAULT",
	          "eventType": "SERVICE_STATE_CHANGE",
	          "isBlockedBilling": false,
	          "isBlockedEntitlement": false,
	          "serviceName": "aaa",
	          "serviceStateName": "bbb",
	          "phase": "PRD_0000000017_PL_000001-discount",
	          "auditLogs": [],
	          "effectiveDate": "2017-03-23"
	        },
	        {
	          "eventId": "801c5a59-5f3d-475d-86f3-0022be068d86",
	          "billingPeriod": "MONTHLY",
	          "product": "PRD_0000000017",
	          "priceList": "DEFAULT",
	          "eventType": "PHASE",
	          "isBlockedBilling": false,
	          "isBlockedEntitlement": false,
	          "serviceName": "entitlement+billing-service",
	          "serviceStateName": "PHASE",
	          "phase": "PRD_0000000017_PL_000001-discount",
	          "auditLogs": [],
	          "effectiveDate": "2017-04-07"
	        },
	        {
	          "eventId": "f4471316-9717-4910-96e9-89680388c94e",
	          "billingPeriod": "MONTHLY",
	          "product": "PRD_0000000017",
	          "priceList": "DEFAULT",
	          "eventType": "PHASE",
	          "isBlockedBilling": false,
	          "isBlockedEntitlement": false,
	          "serviceName": "entitlement+billing-service",
	          "serviceStateName": "PHASE",
	          "phase": "PRD_0000000017_PL_000001-evergreen",
	          "auditLogs": [],
	          "effectiveDate": "2017-06-07"
	        }
	      ],
	      "priceOverrides": [
	        {
	          "phaseName": "PRD_0000000017_PL_000001-trial",
	          "phaseType": "TRIAL",
	          "fixedPrice": 0,
	          "recurringPrice": null
	        },
	        {
	          "phaseName": "PRD_0000000017_PL_000001-discount",
	          "phaseType": "DISCOUNT",
	          "fixedPrice": null,
	          "recurringPrice": 8
	        },
	        {
	          "phaseName": "PRD_0000000017_PL_000001-evergreen",
	          "phaseType": "EVERGREEN",
	          "fixedPrice": null,
	          "recurringPrice": 10
	        }
	      ],
	      "auditLogs": []
	    }
	  ],
	  "timeline": {
	    "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
	    "bundleId": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
	    "externalKey": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
	    "events": [
	      {
	        "eventId": "5f604100-138f-41e7-a14c-b9527c0476b0",
	        "billingPeriod": "MONTHLY",
	        "product": "PRD_0000000017",
	        "priceList": "DEFAULT",
	        "eventType": "START_ENTITLEMENT",
	        "isBlockedBilling": false,
	        "isBlockedEntitlement": false,
	        "serviceName": "entitlement-service",
	        "serviceStateName": "ENT_STARTED",
	        "phase": "PRD_0000000017_PL_000001-discount",
	        "auditLogs": [],
	        "effectiveDate": "2017-03-08"
	      },
	      {
	        "eventId": "adad42eb-24f1-4e03-8270-b5bbe8fe8c9c",
	        "billingPeriod": "MONTHLY",
	        "product": "PRD_0000000017",
	        "priceList": "DEFAULT",
	        "eventType": "START_BILLING",
	        "isBlockedBilling": false,
	        "isBlockedEntitlement": false,
	        "serviceName": "billing-service",
	        "serviceStateName": "START_BILLING",
	        "phase": "PRD_0000000017_PL_000001-trial",
	        "auditLogs": [],
	        "effectiveDate": "2017-03-08"
	      },
	      {
	        "eventId": "797a4f9b-eb9d-4552-b31e-1253d58c7879",
	        "billingPeriod": "MONTHLY",
	        "product": "PRD_0000000017",
	        "priceList": "DEFAULT",
	        "eventType": "SERVICE_STATE_CHANGE",
	        "isBlockedBilling": false,
	        "isBlockedEntitlement": false,
	        "serviceName": "aaa",
	        "serviceStateName": "bbb",
	        "phase": "PRD_0000000017_PL_000001-discount",
	        "auditLogs": [],
	        "effectiveDate": "2017-03-23"
	      },
	      {
	        "eventId": "801c5a59-5f3d-475d-86f3-0022be068d86",
	        "billingPeriod": "MONTHLY",
	        "product": "PRD_0000000017",
	        "priceList": "DEFAULT",
	        "eventType": "PHASE",
	        "isBlockedBilling": false,
	        "isBlockedEntitlement": false,
	        "serviceName": "entitlement+billing-service",
	        "serviceStateName": "PHASE",
	        "phase": "PRD_0000000017_PL_000001-discount",
	        "auditLogs": [],
	        "effectiveDate": "2017-04-07"
	      },
	      {
	        "eventId": "f4471316-9717-4910-96e9-89680388c94e",
	        "billingPeriod": "MONTHLY",
	        "product": "PRD_0000000017",
	        "priceList": "DEFAULT",
	        "eventType": "PHASE",
	        "isBlockedBilling": false,
	        "isBlockedEntitlement": false,
	        "serviceName": "entitlement+billing-service",
	        "serviceStateName": "PHASE",
	        "phase": "PRD_0000000017_PL_000001-evergreen",
	        "auditLogs": [],
	        "effectiveDate": "2017-06-07"
	      }
	    ],
	    "auditLogs": []
	  },
	  "auditLogs": []
	}
]
```

GET /rest/v1/bundles/pagination


### Description
번들을 페이징하여 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [BundleJson](#bundlejson) > array|


### Produces

* `application/json`


<a name="searchbundles"></a>
## Search bundles

```
GET /rest/v1/bundles/search/{searchKey}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/bundles/search/55637b45-fb24-4320-8a9c-5b9f5a987c39?offset=0&limit=100&audit=NONE'

Reponse Example

[
	{
	  "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
	  "bundleId": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
	  "externalKey": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
	  "subscriptions": [
	    {
	      "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
	      "bundleId": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
	      "subscriptionId": "05ed0ff5-d655-4825-aba6-f8885aeb98d2",
	      "externalKey": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
	      "startDate": "2017-03-08",
	      "productName": "PRD_0000000017",
	      "productCategory": "BASE",
	      "billingPeriod": "MONTHLY",
	      "phaseType": "TRIAL",
	      "priceList": "DEFAULT",
	      "planName": "PRD_0000000017_PL_000001",
	      "state": "ACTIVE",
	      "sourceType": "NATIVE",
	      "cancelledDate": null,
	      "chargedThroughDate": "2017-06-10",
	      "billingStartDate": "2017-03-08",
	      "billingEndDate": null,
	      "billCycleDayLocal": 10,
	      "events": [
	        {
	          "eventId": "5f604100-138f-41e7-a14c-b9527c0476b0",
	          "billingPeriod": "MONTHLY",
	          "product": "PRD_0000000017",
	          "priceList": "DEFAULT",
	          "eventType": "START_ENTITLEMENT",
	          "isBlockedBilling": false,
	          "isBlockedEntitlement": false,
	          "serviceName": "entitlement-service",
	          "serviceStateName": "ENT_STARTED",
	          "phase": "PRD_0000000017_PL_000001-discount",
	          "auditLogs": [],
	          "effectiveDate": "2017-03-08"
	        },
	        {
	          "eventId": "adad42eb-24f1-4e03-8270-b5bbe8fe8c9c",
	          "billingPeriod": "MONTHLY",
	          "product": "PRD_0000000017",
	          "priceList": "DEFAULT",
	          "eventType": "START_BILLING",
	          "isBlockedBilling": false,
	          "isBlockedEntitlement": false,
	          "serviceName": "billing-service",
	          "serviceStateName": "START_BILLING",
	          "phase": "PRD_0000000017_PL_000001-trial",
	          "auditLogs": [],
	          "effectiveDate": "2017-03-08"
	        },
	        {
	          "eventId": "797a4f9b-eb9d-4552-b31e-1253d58c7879",
	          "billingPeriod": "MONTHLY",
	          "product": "PRD_0000000017",
	          "priceList": "DEFAULT",
	          "eventType": "SERVICE_STATE_CHANGE",
	          "isBlockedBilling": false,
	          "isBlockedEntitlement": false,
	          "serviceName": "aaa",
	          "serviceStateName": "bbb",
	          "phase": "PRD_0000000017_PL_000001-discount",
	          "auditLogs": [],
	          "effectiveDate": "2017-03-23"
	        },
	        {
	          "eventId": "801c5a59-5f3d-475d-86f3-0022be068d86",
	          "billingPeriod": "MONTHLY",
	          "product": "PRD_0000000017",
	          "priceList": "DEFAULT",
	          "eventType": "PHASE",
	          "isBlockedBilling": false,
	          "isBlockedEntitlement": false,
	          "serviceName": "entitlement+billing-service",
	          "serviceStateName": "PHASE",
	          "phase": "PRD_0000000017_PL_000001-discount",
	          "auditLogs": [],
	          "effectiveDate": "2017-04-07"
	        },
	        {
	          "eventId": "f4471316-9717-4910-96e9-89680388c94e",
	          "billingPeriod": "MONTHLY",
	          "product": "PRD_0000000017",
	          "priceList": "DEFAULT",
	          "eventType": "PHASE",
	          "isBlockedBilling": false,
	          "isBlockedEntitlement": false,
	          "serviceName": "entitlement+billing-service",
	          "serviceStateName": "PHASE",
	          "phase": "PRD_0000000017_PL_000001-evergreen",
	          "auditLogs": [],
	          "effectiveDate": "2017-06-07"
	        }
	      ],
	      "priceOverrides": [
	        {
	          "phaseName": "PRD_0000000017_PL_000001-trial",
	          "phaseType": "TRIAL",
	          "fixedPrice": 0,
	          "recurringPrice": null
	        },
	        {
	          "phaseName": "PRD_0000000017_PL_000001-discount",
	          "phaseType": "DISCOUNT",
	          "fixedPrice": null,
	          "recurringPrice": 8
	        },
	        {
	          "phaseName": "PRD_0000000017_PL_000001-evergreen",
	          "phaseType": "EVERGREEN",
	          "fixedPrice": null,
	          "recurringPrice": 10
	        }
	      ],
	      "auditLogs": []
	    }
	  ],
	  "timeline": {
	    "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
	    "bundleId": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
	    "externalKey": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
	    "events": [
	      {
	        "eventId": "5f604100-138f-41e7-a14c-b9527c0476b0",
	        "billingPeriod": "MONTHLY",
	        "product": "PRD_0000000017",
	        "priceList": "DEFAULT",
	        "eventType": "START_ENTITLEMENT",
	        "isBlockedBilling": false,
	        "isBlockedEntitlement": false,
	        "serviceName": "entitlement-service",
	        "serviceStateName": "ENT_STARTED",
	        "phase": "PRD_0000000017_PL_000001-discount",
	        "auditLogs": [],
	        "effectiveDate": "2017-03-08"
	      },
	      {
	        "eventId": "adad42eb-24f1-4e03-8270-b5bbe8fe8c9c",
	        "billingPeriod": "MONTHLY",
	        "product": "PRD_0000000017",
	        "priceList": "DEFAULT",
	        "eventType": "START_BILLING",
	        "isBlockedBilling": false,
	        "isBlockedEntitlement": false,
	        "serviceName": "billing-service",
	        "serviceStateName": "START_BILLING",
	        "phase": "PRD_0000000017_PL_000001-trial",
	        "auditLogs": [],
	        "effectiveDate": "2017-03-08"
	      },
	      {
	        "eventId": "797a4f9b-eb9d-4552-b31e-1253d58c7879",
	        "billingPeriod": "MONTHLY",
	        "product": "PRD_0000000017",
	        "priceList": "DEFAULT",
	        "eventType": "SERVICE_STATE_CHANGE",
	        "isBlockedBilling": false,
	        "isBlockedEntitlement": false,
	        "serviceName": "aaa",
	        "serviceStateName": "bbb",
	        "phase": "PRD_0000000017_PL_000001-discount",
	        "auditLogs": [],
	        "effectiveDate": "2017-03-23"
	      },
	      {
	        "eventId": "801c5a59-5f3d-475d-86f3-0022be068d86",
	        "billingPeriod": "MONTHLY",
	        "product": "PRD_0000000017",
	        "priceList": "DEFAULT",
	        "eventType": "PHASE",
	        "isBlockedBilling": false,
	        "isBlockedEntitlement": false,
	        "serviceName": "entitlement+billing-service",
	        "serviceStateName": "PHASE",
	        "phase": "PRD_0000000017_PL_000001-discount",
	        "auditLogs": [],
	        "effectiveDate": "2017-04-07"
	      },
	      {
	        "eventId": "f4471316-9717-4910-96e9-89680388c94e",
	        "billingPeriod": "MONTHLY",
	        "product": "PRD_0000000017",
	        "priceList": "DEFAULT",
	        "eventType": "PHASE",
	        "isBlockedBilling": false,
	        "isBlockedEntitlement": false,
	        "serviceName": "entitlement+billing-service",
	        "serviceStateName": "PHASE",
	        "phase": "PRD_0000000017_PL_000001-evergreen",
	        "auditLogs": [],
	        "effectiveDate": "2017-06-07"
	      }
	    ],
	    "auditLogs": []
	  },
	  "auditLogs": []
	}
]
```

GET /rest/v1/bundles/search/{searchKey}


### Description
주어진 검색어로 번들을 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**searchKey**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [BundleJson](#bundlejson) > array|


### Produces

* `application/json`


<a name="getbundle"></a>
## Retrieve a bundle by id

```
GET /rest/v1/bundles/{bundleId}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/bundles/55637b45-fb24-4320-8a9c-5b9f5a987c39?audit=NONE'


Reponse Example

{
  "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
  "bundleId": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
  "externalKey": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
  "subscriptions": [
    {
      "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
      "bundleId": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
      "subscriptionId": "05ed0ff5-d655-4825-aba6-f8885aeb98d2",
      "externalKey": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
      "startDate": "2017-03-08",
      "productName": "PRD_0000000017",
      "productCategory": "BASE",
      "billingPeriod": "MONTHLY",
      "phaseType": "TRIAL",
      "priceList": "DEFAULT",
      "planName": "PRD_0000000017_PL_000001",
      "state": "ACTIVE",
      "sourceType": "NATIVE",
      "cancelledDate": null,
      "chargedThroughDate": "2017-06-10",
      "billingStartDate": "2017-03-08",
      "billingEndDate": null,
      "billCycleDayLocal": 10,
      "events": [
        {
          "eventId": "5f604100-138f-41e7-a14c-b9527c0476b0",
          "billingPeriod": "MONTHLY",
          "product": "PRD_0000000017",
          "priceList": "DEFAULT",
          "eventType": "START_ENTITLEMENT",
          "isBlockedBilling": false,
          "isBlockedEntitlement": false,
          "serviceName": "entitlement-service",
          "serviceStateName": "ENT_STARTED",
          "phase": "PRD_0000000017_PL_000001-discount",
          "auditLogs": [],
          "effectiveDate": "2017-03-08"
        },
        {
          "eventId": "adad42eb-24f1-4e03-8270-b5bbe8fe8c9c",
          "billingPeriod": "MONTHLY",
          "product": "PRD_0000000017",
          "priceList": "DEFAULT",
          "eventType": "START_BILLING",
          "isBlockedBilling": false,
          "isBlockedEntitlement": false,
          "serviceName": "billing-service",
          "serviceStateName": "START_BILLING",
          "phase": "PRD_0000000017_PL_000001-trial",
          "auditLogs": [],
          "effectiveDate": "2017-03-08"
        },
        {
          "eventId": "797a4f9b-eb9d-4552-b31e-1253d58c7879",
          "billingPeriod": "MONTHLY",
          "product": "PRD_0000000017",
          "priceList": "DEFAULT",
          "eventType": "SERVICE_STATE_CHANGE",
          "isBlockedBilling": false,
          "isBlockedEntitlement": false,
          "serviceName": "aaa",
          "serviceStateName": "bbb",
          "phase": "PRD_0000000017_PL_000001-discount",
          "auditLogs": [],
          "effectiveDate": "2017-03-23"
        },
        {
          "eventId": "801c5a59-5f3d-475d-86f3-0022be068d86",
          "billingPeriod": "MONTHLY",
          "product": "PRD_0000000017",
          "priceList": "DEFAULT",
          "eventType": "PHASE",
          "isBlockedBilling": false,
          "isBlockedEntitlement": false,
          "serviceName": "entitlement+billing-service",
          "serviceStateName": "PHASE",
          "phase": "PRD_0000000017_PL_000001-discount",
          "auditLogs": [],
          "effectiveDate": "2017-04-07"
        },
        {
          "eventId": "f4471316-9717-4910-96e9-89680388c94e",
          "billingPeriod": "MONTHLY",
          "product": "PRD_0000000017",
          "priceList": "DEFAULT",
          "eventType": "PHASE",
          "isBlockedBilling": false,
          "isBlockedEntitlement": false,
          "serviceName": "entitlement+billing-service",
          "serviceStateName": "PHASE",
          "phase": "PRD_0000000017_PL_000001-evergreen",
          "auditLogs": [],
          "effectiveDate": "2017-06-07"
        }
      ],
      "priceOverrides": [
        {
          "phaseName": "PRD_0000000017_PL_000001-trial",
          "phaseType": "TRIAL",
          "fixedPrice": 0,
          "recurringPrice": null
        },
        {
          "phaseName": "PRD_0000000017_PL_000001-discount",
          "phaseType": "DISCOUNT",
          "fixedPrice": null,
          "recurringPrice": 8
        },
        {
          "phaseName": "PRD_0000000017_PL_000001-evergreen",
          "phaseType": "EVERGREEN",
          "fixedPrice": null,
          "recurringPrice": 10
        }
      ],
      "auditLogs": []
    }
  ],
  "timeline": {
    "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "bundleId": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
    "externalKey": "55637b45-fb24-4320-8a9c-5b9f5a987c39",
    "events": [
      {
        "eventId": "5f604100-138f-41e7-a14c-b9527c0476b0",
        "billingPeriod": "MONTHLY",
        "product": "PRD_0000000017",
        "priceList": "DEFAULT",
        "eventType": "START_ENTITLEMENT",
        "isBlockedBilling": false,
        "isBlockedEntitlement": false,
        "serviceName": "entitlement-service",
        "serviceStateName": "ENT_STARTED",
        "phase": "PRD_0000000017_PL_000001-discount",
        "auditLogs": [],
        "effectiveDate": "2017-03-08"
      },
      {
        "eventId": "adad42eb-24f1-4e03-8270-b5bbe8fe8c9c",
        "billingPeriod": "MONTHLY",
        "product": "PRD_0000000017",
        "priceList": "DEFAULT",
        "eventType": "START_BILLING",
        "isBlockedBilling": false,
        "isBlockedEntitlement": false,
        "serviceName": "billing-service",
        "serviceStateName": "START_BILLING",
        "phase": "PRD_0000000017_PL_000001-trial",
        "auditLogs": [],
        "effectiveDate": "2017-03-08"
      },
      {
        "eventId": "797a4f9b-eb9d-4552-b31e-1253d58c7879",
        "billingPeriod": "MONTHLY",
        "product": "PRD_0000000017",
        "priceList": "DEFAULT",
        "eventType": "SERVICE_STATE_CHANGE",
        "isBlockedBilling": false,
        "isBlockedEntitlement": false,
        "serviceName": "aaa",
        "serviceStateName": "bbb",
        "phase": "PRD_0000000017_PL_000001-discount",
        "auditLogs": [],
        "effectiveDate": "2017-03-23"
      },
      {
        "eventId": "801c5a59-5f3d-475d-86f3-0022be068d86",
        "billingPeriod": "MONTHLY",
        "product": "PRD_0000000017",
        "priceList": "DEFAULT",
        "eventType": "PHASE",
        "isBlockedBilling": false,
        "isBlockedEntitlement": false,
        "serviceName": "entitlement+billing-service",
        "serviceStateName": "PHASE",
        "phase": "PRD_0000000017_PL_000001-discount",
        "auditLogs": [],
        "effectiveDate": "2017-04-07"
      },
      {
        "eventId": "f4471316-9717-4910-96e9-89680388c94e",
        "billingPeriod": "MONTHLY",
        "product": "PRD_0000000017",
        "priceList": "DEFAULT",
        "eventType": "PHASE",
        "isBlockedBilling": false,
        "isBlockedEntitlement": false,
        "serviceName": "entitlement+billing-service",
        "serviceStateName": "PHASE",
        "phase": "PRD_0000000017_PL_000001-evergreen",
        "auditLogs": [],
        "effectiveDate": "2017-06-07"
      }
    ],
    "auditLogs": []
  },
  "auditLogs": []
}
```

GET /rest/v1/bundles/{bundleId}


### Description
아이디로 번들을 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**bundleId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[BundleJson](#bundlejson)|
|**400**|Invalid bundle id supplied|No Content|
|**404**|Bundle not found|No Content|


### Produces

* `application/json`


<a name="transferbundle"></a>
## Transfer a bundle to another account

```
PUT /rest/v1/bundles/{bundleId}

Request Example

curl -X PUT 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "accountId": "d2059e29-463e-4e4e-b2d4-8d1294e9e150"
}' 
'http://localhost:18080/rest/v1/bundles/baf3c2dd-c1ff-4ad3-acff-404c82d82f5c?billingPolicy=END_OF_TERM'


Reponse Example

201 Created
```

PUT /rest/v1/bundles/{bundleId}


### Description
번들을 다른 구매자 계정으로 이전시킨다.(과금 주기 또한 동일하게 이전된다.)


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string||
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string||
|**Header**|**X-Killbill-Reason**  <br>*optional*|string||
|**Path**|**bundleId**  <br>*required*|string||
|**Query**|**billingPolicy**  <br>*optional*|string|`"END_OF_TERM"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**requestedDate**  <br>*optional*|string||
|**Body**|**body**  <br>*optional*|[BundleJson](#bundlejson)||


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid bundle id, requested date or policy supplied|No Content|
|**404**|Bundle not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="addbundleblockingstate"></a>
## Block a bundle

```
PUT /rest/v1/bundles/{bundleId}/block

Request Example

curl -X PUT 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "service": "aaa",
  "stateName": "bbb",
  "blockChange": false,
  "blockEntitlement": false,
  "blockBilling": false,
  "type": "SUBSCRIPTION"
}' 
'http://localhost:18080/rest/v1/bundles/25eb7fc1-7927-4b4c-90ee-9388931bb593/block'


Reponse Example

200 OK
```

PUT /rest/v1/bundles/{bundleId}/block


### Description
번들을 정지시킨다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**bundleId**  <br>*required*|string|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Query**|**requestedDate**  <br>*optional*|string|
|**Body**|**body**  <br>*optional*|[BlockingStateJson](#blockingstatejson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid bundle id supplied|No Content|
|**404**|Bundle not found|No Content|


### Consumes

* `application/json`


<a name="createbundlecustomfields"></a>
## Add custom fields to bundle

```
POST /rest/v1/bundles/{bundleId}/customFields

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '[
  {
    "name": "key1",
    "value": "value1"
  }
]' 
'http://localhost:18080/rest/v1/bundles/25eb7fc1-7927-4b4c-90ee-9388931bb593/customFields'


Reponse Example

201 Created
```

POST /rest/v1/bundles/{bundleId}/customFields


### Description
번들에 커스텀 필드를 추가한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**bundleId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|< [CustomFieldJson](#customfieldjson) > array|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid bundle id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getbundlecustomfields"></a>
## Retrieve bundle custom fields

```
GET /rest/v1/bundles/{bundleId}/customFields

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/bundles/25eb7fc1-7927-4b4c-90ee-9388931bb593/customFields?audit=NONE'


Reponse Example

[
  {
    "customFieldId": "4a66b53e-bce3-439f-9a78-2888eff82b6a",
    "objectId": "25eb7fc1-7927-4b4c-90ee-9388931bb593",
    "objectType": "BUNDLE",
    "name": "key1",
    "value": "value1",
    "auditLogs": []
  }
]
```

GET /rest/v1/bundles/{bundleId}/customFields


### Description
번들의 커스텀 필드를 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**bundleId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [CustomFieldJson](#customfieldjson) > array|
|**400**|Invalid bundle id supplied|No Content|


### Produces

* `application/json`


<a name="deletebundlecustomfields"></a>
## Remove custom fields from bundle

```
DELETE /rest/v1/bundles/{bundleId}/customFields

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/bundles/25eb7fc1-7927-4b4c-90ee-9388931bb593/customFields?customFieldList=4a66b53e-bce3-439f-9a78-2888eff82b6a'


Reponse Example

200 no content
```

DELETE /rest/v1/bundles/{bundleId}/customFields


### Description
번들에 부여된 커스텀 필드를 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**bundleId**  <br>*required*|string|
|**Query**|**customFieldList**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid bundle id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="pausebundle"></a>
## Pause a bundle

```
PUT /rest/v1/bundles/{bundleId}/pause

Request Example

curl -X PUT 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/bundles/25eb7fc1-7927-4b4c-90ee-9388931bb593/pause'


Reponse Example

200 OK
```

PUT /rest/v1/bundles/{bundleId}/pause


### Description
번들을 일시정지 시킨다.(일시정지 된 번들을 정지 기간동안 과금이 부과되지 않는다.)


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**bundleId**  <br>*required*|string|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Query**|**requestedDate**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid bundle id supplied|No Content|
|**404**|Bundle not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="resumebundle"></a>
## Resume a bundle

```
PUT /rest/v1/bundles/{bundleId}/resume

Request Example

curl -X PUT 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/bundles/25eb7fc1-7927-4b4c-90ee-9388931bb593/resume'


Reponse Example

200 OK
```

PUT /rest/v1/bundles/{bundleId}/resume


### Description
번들의 일시정지를 해제한다. (해지된 시점부터 과금이 재집행되며, 결제 주기는 정지되기 전과 동일하게 유지된다.)


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**bundleId**  <br>*required*|string|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Query**|**requestedDate**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid bundle id supplied|No Content|
|**404**|Bundle not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="createbundletags"></a>
## Add tags to bundle

```
POST /rest/v1/bundles/{bundleId}/tags

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/bundles/25eb7fc1-7927-4b4c-90ee-9388931bb593/tags?tagList=00000000-0000-0000-0000-000000000001'


Reponse Example

201 Created
```

POST /rest/v1/bundles/{bundleId}/tags


### Description
번들에 태그를 추가한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**bundleId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid bundle id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getbundletags"></a>
## Retrieve bundle tags

```
GET /rest/v1/bundles/{bundleId}/tags

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/bundles/25eb7fc1-7927-4b4c-90ee-9388931bb593/tags?audit=NONE&includedDeleted=false'


Reponse Example

[
  {
    "tagId": "a1b43534-d941-4a11-bf13-2d00927cdc70",
    "objectType": "BUNDLE",
    "objectId": "25eb7fc1-7927-4b4c-90ee-9388931bb593",
    "tagDefinitionId": "00000000-0000-0000-0000-000000000001",
    "tagDefinitionName": "AUTO_PAY_OFF",
    "auditLogs": []
  }
]
```

GET /rest/v1/bundles/{bundleId}/tags


### Description
번들의 태그를 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**bundleId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**includedDeleted**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [TagJson](#tagjson) > array|
|**400**|Invalid bundle id supplied|No Content|
|**404**|Bundle not found|No Content|


### Produces

* `application/json`


<a name="deletebundletags"></a>
## Remove tags from bundle

```
DELETE /rest/v1/bundles/{bundleId}/tags

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/bundles/25eb7fc1-7927-4b4c-90ee-9388931bb593/tags?tagList=00000000-0000-0000-0000-000000000001'


Reponse Example

200 no content
```

DELETE /rest/v1/bundles/{bundleId}/tags


### Description
번들에 부여된 태그를 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**bundleId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid bundle id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="credits_resource"></a>
# Credits

<a name="createcredit"></a>
## Create a credit

```
POST /rest/v1/credits

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "creditAmount": 20,
  "currency": "USD",
  "accountId": "d2059e29-463e-4e4e-b2d4-8d1294e9e150"
}' 
'http://localhost:18080/rest/v1/credits?autoCommit=true'


Reponse Example

201 Created
```

POST /rest/v1/credits


### Description
구매자 계정, 또는 인보이스에 가상 화폐를 추가한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string||
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string||
|**Header**|**X-Killbill-Reason**  <br>*optional*|string||
|**Query**|**autoCommit**  <br>*optional*|boolean|`"false"`|
|**Body**|**body**  <br>*optional*|[CreditJson](#creditjson)||


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getcredit"></a>
## Retrieve a credit by id

```
GET /rest/v1/credits/{creditId}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/credits/aa57e70f-35a9-4d35-ad7e-62432b27f953'


Reponse Example

{
  "creditAmount": 20,
  "currency": "USD",
  "invoiceId": "28367434-9253-45f2-9da0-119cc972c11a",
  "invoiceNumber": "541",
  "effectiveDate": "2017-03-24",
  "accountId": "d2059e29-463e-4e4e-b2d4-8d1294e9e150",
  "description": "Invoice adjustment",
  "auditLogs": null
}
```

GET /rest/v1/credits/{creditId}


### Description
가장 화폐 (credit) 를 아이디로 조회한다. 구매자 계정의 가상 화폐 잔액은 credit 들의 sum 으로 계산된다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**creditId**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[CreditJson](#creditjson)|
|**400**|Invalid credit id supplied|No Content|
|**404**|Credit not found|No Content|


### Produces

* `application/json`


<a name="customfields_resource"></a>
# CustomFields

<a name="getcustomfields"></a>
## List custom fields

```
GET /rest/v1/customFields/pagination

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/customFields/pagination?offset=0&limit=4&audit=NONE'


Reponse Example

[
  {
    "customFieldId": "e55d0eb3-fe66-4948-94d3-f4ad4bf0c317",
    "objectId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "objectType": "ACCOUNT",
    "name": "CustomKey1",
    "value": "Value1",
    "auditLogs": []
  },
  {
    "customFieldId": "0225f1b6-7132-4452-aacb-bdebcea1a1d6",
    "objectId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "objectType": "ACCOUNT",
    "name": "CustomKey2",
    "value": "Value2",
    "auditLogs": []
  }
]
```

GET /rest/v1/customFields/pagination


### Description
커스텀 필드를 페이징하여 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [CustomFieldJson](#customfieldjson) > array|


### Produces

* `application/json`


<a name="searchcustomfields"></a>
## Search custom fields

```
GET /rest/v1/customFields/search/{searchKey}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/customFields/search/Custom?offset=0&limit=100&audit=NONE'


Reponse Example

[
  {
    "customFieldId": "e55d0eb3-fe66-4948-94d3-f4ad4bf0c317",
    "objectId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "objectType": "ACCOUNT",
    "name": "CustomKey1",
    "value": "Value1",
    "auditLogs": []
  },
  {
    "customFieldId": "0225f1b6-7132-4452-aacb-bdebcea1a1d6",
    "objectId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "objectType": "ACCOUNT",
    "name": "CustomKey2",
    "value": "Value2",
    "auditLogs": []
  }
]
```

GET /rest/v1/customFields/search/{searchKey}


### Description
주어진 검색어로 커스텀 필드를 페이징하여 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**searchKey**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [CustomFieldJson](#customfieldjson) > array|


### Produces

* `application/json`


<a name="invoicepayments_resource"></a>
# InvoicePayments

<a name="getinvoicepayment"></a>
## Retrieve a payment by id

```
GET /rest/v1/invoicePayments/{paymentId}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/invoicePayments/bb936c8f-3ebe-4a00-aab1-ddea3f94f66f?withPluginInfo=false&withAttempts=false&audit=NONE'


Reponse Example

{
  "targetInvoiceId": "db5bf40f-26e2-4772-ab92-8e3ac3d1d70c",
  "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
  "paymentId": "bb936c8f-3ebe-4a00-aab1-ddea3f94f66f",
  "paymentNumber": "339",
  "paymentExternalKey": "e22d6458-a768-46c2-ab81-8c77cca41fdc",
  "authAmount": 0,
  "capturedAmount": 0,
  "purchasedAmount": 25.48,
  "refundedAmount": 0,
  "creditedAmount": 0,
  "currency": "USD",
  "paymentMethodId": "32cdf8e8-cef1-4995-afcb-ac16eefe7672",
  "transactions": [
    {
      "transactionId": "69b1bd2a-136f-4e3a-80cf-13dda9bbc40f",
      "transactionExternalKey": "16ffca08-353a-4d82-a83d-a8826e321b20",
      "paymentId": "bb936c8f-3ebe-4a00-aab1-ddea3f94f66f",
      "paymentExternalKey": "e22d6458-a768-46c2-ab81-8c77cca41fdc",
      "transactionType": "PURCHASE",
      "amount": 25.48,
      "currency": "USD",
      "effectiveDate": "2017-03-24T02:56:13.000Z",
      "processedAmount": 25.48,
      "processedCurrency": "USD",
      "status": "SUCCESS",
      "gatewayErrorCode": null,
      "gatewayErrorMsg": "Success",
      "firstPaymentReferenceId": null,
      "secondPaymentReferenceId": null,
      "properties": null,
      "auditLogs": []
    }
  ],
  "paymentAttempts": null,
  "auditLogs": []
}
```

GET /rest/v1/invoicePayments/{paymentId}


### Description
인보이스 결제 이력을 아이디로 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**paymentId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**withAttempts**  <br>*optional*|boolean|`"false"`|
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[InvoicePaymentJson](#invoicepaymentjson)|
|**400**|Invalid payment id supplied|No Content|
|**404**|Payment not found|No Content|


### Produces

* `application/json`


<a name="createchargebackreversal"></a>
## Record a chargebackReversal

```
POST /rest/v1/invoicePayments/{paymentId}/chargebackReversals

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "transactionExternalKey": "8e456351-5eca-4eeb-9b9b-dee08f68f4ef",
  "amount": 10,
   "currency": "USD"
}' 
'http://localhost:18080/rest/v1/invoicePayments/57ac1a36-47b4-471c-b72a-44d3009df07c/chargebackReversals'


Reponse Example

201 Created
```

POST /rest/v1/invoicePayments/{paymentId}/chargebackReversals


### Description
주어진 인보이스 결제이력의 chargeback(지불 거절) 요청을 취소한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|[InvoicePaymentTransactionJson](#invoicepaymenttransactionjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment id supplied|No Content|
|**404**|Account or payment not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="createchargeback"></a>
## Record a chargeback

```
POST /rest/v1/invoicePayments/{paymentId}/chargebacks

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "amount": 10,
  "currency": "USD"
}' 
'http://localhost:18080/rest/v1/invoicePayments/57ac1a36-47b4-471c-b72a-44d3009df07c/chargebacks'


Reponse Example

201 Created
```

POST /rest/v1/invoicePayments/{paymentId}/chargebacks


### Description
인보이스 결제이력에 지불거절(chargebacks) 요청을 한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|[InvoicePaymentTransactionJson](#invoicepaymenttransactionjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment id supplied|No Content|
|**404**|Account or payment not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="createinvoicepaymentcustomfields"></a>
## Add custom fields to payment

```
POST /rest/v1/invoicePayments/{paymentId}/customFields

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '[
  {
    "name": "key1",
    "value": "valued1"
  }
]' 
'http://localhost:18080/rest/v1/invoicePayments/57ac1a36-47b4-471c-b72a-44d3009df07c/customFields'


Reponse Example

201 Created
```

POST /rest/v1/invoicePayments/{paymentId}/customFields


### Description
인보이스 결제이력에 커스텀 필드를 추가한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|< [CustomFieldJson](#customfieldjson) > array|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getinvoicepaymentcustomfields"></a>
## Retrieve payment custom fields

```
GET /rest/v1/invoicePayments/{paymentId}/customFields

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/invoicePayments/57ac1a36-47b4-471c-b72a-44d3009df07c/customFields?audit=NONE'



Reponse Example

[
  {
    "customFieldId": "f7572d2f-c579-4d24-8079-803e4c73b5d9",
    "objectId": "57ac1a36-47b4-471c-b72a-44d3009df07c",
    "objectType": "PAYMENT",
    "name": "key1",
    "value": "valued1",
    "auditLogs": []
  }
]
```

GET /rest/v1/invoicePayments/{paymentId}/customFields


### Description
인보이스 결제이력의 커스텀 필드를 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**paymentId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [CustomFieldJson](#customfieldjson) > array|
|**400**|Invalid payment id supplied|No Content|


### Produces

* `application/json`


<a name="deleteinvoicepaymentcustomfields"></a>
## Remove custom fields from payment

```
DELETE /rest/v1/invoicePayments/{paymentId}/customFields

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/invoicePayments/57ac1a36-47b4-471c-b72a-44d3009df07c/customFields?customFieldList=f7572d2f-c579-4d24-8079-803e4c73b5d9'


Reponse Example

200 OK
```

DELETE /rest/v1/invoicePayments/{paymentId}/customFields


### Description
인보이스 결제이력에 커스텀 필드를 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**customFieldList**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="createrefundwithadjustments"></a>
## Refund a payment, and adjust the invoice if needed
```
POST /rest/v1/invoicePayments/{paymentId}/refunds
```


### Description
인보이스 결제이력에 환불(refund) 요청을 한다. 환불 요청시, Adjust 할 인보이스 아이템(상세 항목) 및 금액을 정할 수 있다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string||
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string||
|**Header**|**X-Killbill-Reason**  <br>*optional*|string||
|**Path**|**paymentId**  <br>*required*|string||
|**Query**|**externalPayment**  <br>*optional*|boolean|`"false"`|
|**Query**|**paymentMethodId**  <br>*optional*|string||
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Body**|**body**  <br>*optional*|[InvoicePaymentTransactionJson](#invoicepaymenttransactionjson)||


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment id supplied|No Content|
|**404**|Account or payment not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="createinvoicepaymenttags"></a>
## Add tags to payment

```
POST /rest/v1/invoicePayments/{paymentId}/tags

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/invoicePayments/57ac1a36-47b4-471c-b72a-44d3009df07c/tags?tagList=00000000-0000-0000-0000-000000000001'


Reponse Example

201 Created
```

POST /rest/v1/invoicePayments/{paymentId}/tags


### Description
인보이스 결제이력에 태그를 추가한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getinvoicepaymenttags"></a>
## Retrieve payment tags

```
GET /rest/v1/invoicePayments/{paymentId}/tags

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/invoicePayments/57ac1a36-47b4-471c-b72a-44d3009df07c/tags?audit=NONE&includedDeleted=false'


Reponse Example

[
  {
    "tagId": "310eeeab-fa45-4f2a-9cda-2a0199e8fe80",
    "objectType": "PAYMENT",
    "objectId": "57ac1a36-47b4-471c-b72a-44d3009df07c",
    "tagDefinitionId": "00000000-0000-0000-0000-000000000001",
    "tagDefinitionName": "AUTO_PAY_OFF",
    "auditLogs": []
  }
]
```

GET /rest/v1/invoicePayments/{paymentId}/tags


### Description
인보이스 결제이력의 태그를 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**paymentId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**includedDeleted**  <br>*optional*|boolean|`"false"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [TagJson](#tagjson) > array|
|**400**|Invalid payment id supplied|No Content|
|**404**|Payment not found|No Content|


### Produces

* `application/json`


<a name="deleteinvoicepaymenttags"></a>
## Remove tags from payment

```
DELETE /rest/v1/invoicePayments/{paymentId}/tags

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/invoicePayments/57ac1a36-47b4-471c-b72a-44d3009df07c/tags?tagList=00000000-0000-0000-0000-000000000001'


Reponse Example

200 no content
```

DELETE /rest/v1/invoicePayments/{paymentId}/tags


### Description
인보이스 결제이력에 태그를 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="invoices_resource"></a>
# Invoices

<a name="createfutureinvoice"></a>
## Trigger an invoice generation

```
POST /rest/v1/invoices

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/invoices?accountId=d2059e29-463e-4e4e-b2d4-8d1294e9e150&targetDate=2017-06-21'


Reponse Example

201 Created
```

POST /rest/v1/invoices


### Description
미래에 발급될 인보이스를 앞당겨 발급한다.(인보이스가 실제로 생성,발송되고 결제도 이루어진다.) targetDate 가 마지막 인보이스로부터 다음 결제 예정일보다 이전일 경우 발급되지 않는다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Query**|**accountId**  <br>*optional*|string|
|**Query**|**targetDate**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[InvoiceJson](#invoicejson)|
|**400**|Invalid account id or target datetime supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="createexternalcharges"></a>
## Create external charge(s)

```
POST /rest/v1/invoices/charges/{accountId}

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '[
  {
    "description": "예제 인보이스 결제",
    "amount": 10,
    "currency": "USD"
  }
]' 
'http://localhost:18080/rest/v1/invoices/charges/9c3f0bea-d1e1-40ae-98bf-81d317885288?payInvoice=false&autoCommit=false'


Reponse Example

[
  {
    "invoiceItemId": "3813656e-a59a-4440-b75d-cb3accf5fca9",
    "invoiceId": "aaf51978-8db2-4858-90b7-e3b0632de3bb",
    "linkedInvoiceItemId": null,
    "accountId": "9c3f0bea-d1e1-40ae-98bf-81d317885288",
    "childAccountId": null,
    "bundleId": null,
    "subscriptionId": null,
    "planName": null,
    "phaseName": null,
    "usageName": null,
    "itemType": "EXTERNAL_CHARGE",
    "description": "예제 인보이스 결제",
    "startDate": "2017-03-24",
    "endDate": null,
    "amount": 10,
    "currency": "USD",
    "childItems": null,
    "auditLogs": null
  }
]
```

POST /rest/v1/invoices/charges/{accountId}


### Description
구매자에게 임의의 인보이스를 발급한다. 이 인보이스는 플랜과 상관이 없는 독립적인 인보이스이며, 임의이 설명과 함께 구매자에게 발송되며 결제된다. 만일 인보이스 아이디를 지정하게 된다면, 지정된 인보이스에 External charge item 이 추가된다. 인보이스 아이디를 지정할 경우 자동 결제 및 재발송되지 않으므로 결제 및 발송을 수행해주어야 한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string||
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string||
|**Header**|**X-Killbill-Reason**  <br>*optional*|string||
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**autoCommit**  <br>*optional*|boolean|`"false"`|
|**Query**|**payInvoice**  <br>*optional*|boolean|`"false"`|
|**Query**|**paymentExternalKey**  <br>*optional*|string||
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**requestedDate**  <br>*optional*|string||
|**Query**|**transactionExternalKey**  <br>*optional*|string||
|**Body**|**body**  <br>*required*|[ListInvoiceItemJson](#listinvoiceitemjson)||


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [InvoiceItemJson](#invoiceitemjson) > array|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="generatedryruninvoice"></a>
## Generate a dryRun invoice

```
POST /rest/v1/invoices/dryRun

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "dryRunType": "UPCOMING_INVOICE"
}' 
'http://localhost:18080/rest/v1/invoices/dryRun?accountId=9c3f0bea-d1e1-40ae-98bf-81d317885288'


Reponse Example

{
  "amount": 80,
  "currency": "USD",
  "status": "COMMITTED",
  "creditAdj": 0,
  "refundAdj": 0,
  "invoiceId": "53a16c58-99c7-444d-8308-bfeccf2a3a9e",
  "invoiceDate": "2017-03-24",
  "targetDate": "2017-06-24",
  "invoiceNumber": null,
  "balance": 80,
  "accountId": "9c3f0bea-d1e1-40ae-98bf-81d317885288",
  "credits": null,
  "items": [
    {
      "invoiceItemId": "ff9b8d86-b360-4956-b98f-a943e1fb2c34",
      "invoiceId": "53a16c58-99c7-444d-8308-bfeccf2a3a9e",
      "linkedInvoiceItemId": null,
      "accountId": "9c3f0bea-d1e1-40ae-98bf-81d317885288",
      "childAccountId": null,
      "bundleId": "b41f28a8-a25e-4970-a7e5-29c776e75fe9",
      "subscriptionId": "3efe9e71-c586-4431-95e3-3cb3421736a5",
      "planName": "PRD_0000000017_PL_000002",
      "phaseName": "PRD_0000000017_PL_000002-evergreen",
      "usageName": null,
      "itemType": "RECURRING",
      "description": "PRD_0000000017_PL_000002-evergreen",
      "startDate": "2017-06-24",
      "endDate": "2017-07-24",
      "amount": 80,
      "currency": "USD",
      "childItems": null,
      "auditLogs": null
    }
  ],
  "isParentInvoice": false,
  "auditLogs": null,
  "bundleKeys": null
}
```

POST /rest/v1/invoices/dryRun


### Description
미래에 발급될 인보이스를 가상으로 생성해 조회한다.(가상으로 생성된 인보이스는 실제로 발급되지는 않는다.)


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Query**|**accountId**  <br>*optional*|string|
|**Query**|**targetDate**  <br>*optional*|string|
|**Body**|**body**  <br>*optional*|[InvoiceDryRunJson](#invoicedryrunjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[InvoiceJson](#invoicejson)|
|**400**|Invalid account id or target datetime supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getinvoices"></a>
## List invoices

```
GET /rest/v1/invoices/pagination

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/invoices/pagination?offset=0&limit=2&withItems=true&audit=NONE'


Reponse Example

[
  {
    "amount": 0,
    "currency": "USD",
    "status": "COMMITTED",
    "creditAdj": 0,
    "refundAdj": 0,
    "invoiceId": "bde0deba-0c90-4b56-ba8e-ad76ab579940",
    "invoiceDate": "2017-03-08",
    "targetDate": "2017-03-08",
    "invoiceNumber": "426",
    "balance": 0,
    "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "credits": null,
    "items": [],
    "isParentInvoice": false,
    "auditLogs": [],
    "bundleKeys": null
  }
]
```

GET /rest/v1/invoices/pagination


### Description
인보이스를 페이징하여 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|
|**Query**|**withItems**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [InvoiceJson](#invoicejson) > array|


### Produces

* `application/json`


<a name="searchinvoices"></a>
## Search invoices

```
GET /rest/v1/invoices/search/{searchKey}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/invoices/search/bde0deba-0c90-4b56-ba8e-ad76ab579940?offset=0&limit=2&withItems=true&audit=NONE'


Reponse Example

[
  {
    "amount": 0,
    "currency": "USD",
    "status": "COMMITTED",
    "creditAdj": 0,
    "refundAdj": 0,
    "invoiceId": "bde0deba-0c90-4b56-ba8e-ad76ab579940",
    "invoiceDate": "2017-03-08",
    "targetDate": "2017-03-08",
    "invoiceNumber": "426",
    "balance": 0,
    "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "credits": null,
    "items": [],
    "isParentInvoice": false,
    "auditLogs": [],
    "bundleKeys": null
  }
]
```

GET /rest/v1/invoices/search/{searchKey}


### Description
주어진 검색어로 인보이스를 페이징하여 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**searchKey**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|
|**Query**|**withItems**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [InvoiceJson](#invoicejson) > array|


### Produces

* `application/json`


<a name="adjustinvoiceitem"></a>
## Adjust an invoice item

```
POST /rest/v1/invoices/{invoiceId}

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "invoiceItemId": "3813656e-a59a-4440-b75d-cb3accf5fca9",
   "accountId": "9c3f0bea-d1e1-40ae-98bf-81d317885288",
  "amount": 5,
   "currency": "USD"
}' 
'http://localhost:18080/rest/v1/invoices/aaf51978-8db2-4858-90b7-e3b0632de3bb'


Reponse Example

201 Created
```

POST /rest/v1/invoices/{invoiceId}


### Description
인보이스에 포함된 인보이스 아이템 한건을 Adjust(가격 조정) 한다


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**invoiceId**  <br>*required*|string|
|**Query**|**requestedDate**  <br>*optional*|string|
|**Body**|**body**  <br>*optional*|[InvoiceItemJson](#invoiceitemjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id, invoice id or invoice item id supplied|No Content|
|**404**|Invoice not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getinvoice"></a>
## Retrieve an invoice by id

```
GET /rest/v1/invoices/{invoiceId}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/invoices/aaf51978-8db2-4858-90b7-e3b0632de3bb?withItems=true&withChildrenItems=false&audit=NONE'


Reponse Example

{
  "amount": 10,
  "currency": "USD",
  "status": "DRAFT",
  "creditAdj": 0,
  "refundAdj": 0,
  "invoiceId": "aaf51978-8db2-4858-90b7-e3b0632de3bb",
  "invoiceDate": "2017-03-24",
  "targetDate": "2017-03-24",
  "invoiceNumber": "556",
  "balance": 0,
  "accountId": "9c3f0bea-d1e1-40ae-98bf-81d317885288",
  "credits": null,
  "items": [
    {
      "invoiceItemId": "3813656e-a59a-4440-b75d-cb3accf5fca9",
      "invoiceId": "aaf51978-8db2-4858-90b7-e3b0632de3bb",
      "linkedInvoiceItemId": null,
      "accountId": "9c3f0bea-d1e1-40ae-98bf-81d317885288",
      "childAccountId": null,
      "bundleId": null,
      "subscriptionId": null,
      "planName": null,
      "phaseName": null,
      "usageName": null,
      "itemType": "EXTERNAL_CHARGE",
      "description": "예제 인보이스 결제",
      "startDate": "2017-03-24",
      "endDate": null,
      "amount": 10,
      "currency": "USD",
      "childItems": null,
      "auditLogs": []
    }
  ],
  "isParentInvoice": false,
  "auditLogs": [],
  "bundleKeys": null
}
```

GET /rest/v1/invoices/{invoiceId}


### Description
아이디 또는 인보이스 넘버에 해당하는 인보이스를 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**invoiceId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**withChildrenItems**  <br>*optional*|boolean|`"false"`|
|**Query**|**withItems**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[InvoiceJson](#invoicejson)|
|**400**|Invalid invoice id supplied|No Content|
|**404**|Invoice not found|No Content|


### Produces

* `application/json`


<a name="commitinvoice"></a>
## Perform the invoice status transition from DRAFT to COMMITTED

```
PUT /rest/v1/invoices/{invoiceId}/commitInvoice

Request Example

curl -X PUT 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/invoices/aaf51978-8db2-4858-90b7-e3b0632de3bb/commitInvoice'


Reponse Example

200 OK
```

PUT /rest/v1/invoices/{invoiceId}/commitInvoice


### Description
인보이스의 status 를 DRAFT 에서 COMMITTED 상태로 전환한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**invoiceId**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**404**|Invoice not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="createinvoicecustomfields"></a>
## Add custom fields to invoice

```
POST /rest/v1/invoices/{invoiceId}/customFields

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '[
  {
    "name": "key1",
    "value": "value1"
  }
]' 
'http://localhost:18080/rest/v1/invoices/aaf51978-8db2-4858-90b7-e3b0632de3bb/customFields'


Reponse Example

201 Created
```

POST /rest/v1/invoices/{invoiceId}/customFields


### Description
인보이스에 커스텀 필드를 추가한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**invoiceId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|< [CustomFieldJson](#customfieldjson) > array|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid invoice id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getinvoicecustomfields"></a>
## Retrieve invoice custom fields

```
GET /rest/v1/invoices/{invoiceId}/customFields

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/invoices/aaf51978-8db2-4858-90b7-e3b0632de3bb/customFields?audit=NONE'


Reponse Example

[
  {
    "customFieldId": "12512b9d-1c20-4aa7-a0a7-448c34bccba9",
    "objectId": "aaf51978-8db2-4858-90b7-e3b0632de3bb",
    "objectType": "INVOICE",
    "name": "key1",
    "value": "value1",
    "auditLogs": []
  }
]
```

GET /rest/v1/invoices/{invoiceId}/customFields


### Description
인보이스의 커스텀 필드를 반환한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**invoiceId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [CustomFieldJson](#customfieldjson) > array|
|**400**|Invalid invoice id supplied|No Content|


### Produces

* `application/json`


<a name="deleteinvoicecustomfields"></a>
## Remove custom fields from invoice

```
DELETE /rest/v1/invoices/{invoiceId}/customFields

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/invoices/aaf51978-8db2-4858-90b7-e3b0632de3bb/customFields?customFieldList=12512b9d-1c20-4aa7-a0a7-448c34bccba9'


Reponse Example

200 OK
```

DELETE /rest/v1/invoices/{invoiceId}/customFields


### Description
인보이스에 커스텀 필드를 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**invoiceId**  <br>*required*|string|
|**Query**|**customFieldList**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid invoice id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="triggeremailnotificationforinvoice"></a>
## Trigger an email notification for invoice

```
POST /rest/v1/invoices/{invoiceId}/emailNotifications

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/invoices/aaf51978-8db2-4858-90b7-e3b0632de3bb/emailNotifications'


Reponse Example

200 OK
```

POST /rest/v1/invoices/{invoiceId}/emailNotifications


### Description
인보이스를 구매자의 이메일 계정으로 발송한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**invoiceId**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid invoice id supplied|No Content|
|**404**|Account or invoice not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getinvoiceashtml"></a>
## Render an invoice as HTML

```
GET /rest/v1/invoices/{invoiceId}/html

Request Example

curl -X GET 
--header 'Accept: text/html' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/invoices/aaf51978-8db2-4858-90b7-e3b0632de3bb/html'


Reponse Example

<html>
<head>
    <style type="text/css">
        th {
            text-align: left;
            width: 225px;
            border-bottom: solid 2px black;
        }
    </style>
</head>
<body>
<h1>invoiceTitle</h1>
<table>
    <tr>
        <td rowspan=3 width=350px>Insert image here</td>
        <td width=100px/>
        <td width=225px/>
        <td width=225px/>
    </tr>
    <tr>
        <td/>
        <td align=right>invoiceDate</td>
        <td>2017. 3. 24</td>
    </tr>
    <tr>
        <td/>
        <td align=right>invoiceNumber</td>
        <td>556</td>
    </tr>
    <tr>
        <td>companyName</td>
        <td></td>
        <td align=right>accountOwnerName</td>
        <td>Park Seungpil</td>
    </tr>
    <tr>
        <td>companyAddress</td>
        <td/>
        <td/>
        <td>sppark@uengine.org</td>
    </tr>
    <tr>
        <td>companyCityProvincePostalCode</td>
        <td/>
        <td/>
        <td>+821040341807</td>
    </tr>
    <tr>
        <td>companyCountry</td>
        <td/>
        <td/>
        <td/>
    </tr>
</table>
<br/>
<br/>
<br/>
<table>
    <tr>
        <th>Description
        </td>
        <th>BundleName
        </td>
        <th>ServicePeriod
        </td>
        <th>Amount
        </td>
    </tr>
    
    <tr>
        <td>예제 인보이스 결제</td>
        <td></td>
        <td>2017. 3. 24</td>
        <td>USD 10.00</td>
    </tr>
    
    <tr>
        <td>Invoice item adjustment</td>
        <td></td>
        <td>2017. 3. 24 - 2017. 3. 24</td>
        <td>USD -5.00</td>
    </tr>
    
    <tr>
        <td colspan=4/>
    </tr>
    <tr>
        <td colspan=2/>
        <td align=right><strong>invoiceAmount</strong></td>
        <td align=right><strong>5.00</strong></td>
    </tr>
    <tr>
        <td colspan=2/>
        <td align=right><strong>invoiceAmountPaid</strong></td>
        <td align=right><strong>5.00</strong></td>
    </tr>
    <tr>
        <td colspan=2/>
        <td align=right><strong>invoiceBalance</strong></td>
        <td align=right><strong>0.00</strong></td>
    </tr>
</table>
</body>
</html>
```

GET /rest/v1/invoices/{invoiceId}/html


### Description
인보이스를 HTML 형식으로 출력한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**invoiceId**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|string|
|**404**|Invoice not found|No Content|


### Produces

* `text/html`


<a name="createinstantpayment"></a>
## Trigger a payment for invoice

```
POST /rest/v1/invoices/{invoiceId}/payments

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "accountId": "9c3f0bea-d1e1-40ae-98bf-81d317885288",
  "targetInvoiceId": "aaf51978-8db2-4858-90b7-e3b0632de3bb",
  "purchasedAmount": 40,
  "currency": "USD"
}' 
'http://localhost:18080/rest/v1/invoices/aaf51978-8db2-4858-90b7-e3b0632de3bb/payments?externalPayment=false'


Reponse Example

201 Created
```

POST /rest/v1/invoices/{invoiceId}/payments


### Description
인보이스의 잔액을 결제한다. 결제금액은 인보이스의 잔액보다 크지 않아야 한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string||
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string||
|**Header**|**X-Killbill-Reason**  <br>*optional*|string||
|**Path**|**invoiceId**  <br>*required*|string||
|**Query**|**externalPayment**  <br>*optional*|boolean|`"false"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Body**|**body**  <br>*optional*|[InvoicePaymentJson](#invoicepaymentjson)||


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id or invoice id supplied|No Content|
|**404**|Account not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getinvoicepayments"></a>
## Retrieve payments associated with an invoice

```
GET /rest/v1/invoices/{invoiceId}/payments

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/invoices/aaf51978-8db2-4858-90b7-e3b0632de3bb/payments?audit=NONE&withPluginInfo=false&withAttempts=false'


Reponse Example

[
  {
    "targetInvoiceId": "aaf51978-8db2-4858-90b7-e3b0632de3bb",
    "accountId": "9c3f0bea-d1e1-40ae-98bf-81d317885288",
    "paymentId": "d6f30412-94d3-4c8f-be68-b4f338d1d539",
    "paymentNumber": "348",
    "paymentExternalKey": "d6c2508c-cf62-40f4-b124-54fdbeede1e7",
    "authAmount": 0,
    "capturedAmount": 0,
    "purchasedAmount": 5,
    "refundedAmount": 0,
    "creditedAmount": 0,
    "currency": "USD",
    "paymentMethodId": "569830ae-d246-4daa-8671-ea5f5e6431ea",
    "transactions": [
      {
        "transactionId": "9349db4e-a9e3-46f2-bae3-b2e6faa5644d",
        "transactionExternalKey": "005447d2-ff19-4703-996a-a6701822083b",
        "paymentId": "d6f30412-94d3-4c8f-be68-b4f338d1d539",
        "paymentExternalKey": "d6c2508c-cf62-40f4-b124-54fdbeede1e7",
        "transactionType": "PURCHASE",
        "amount": 5,
        "currency": "USD",
        "effectiveDate": "2017-03-24T00:21:04.000Z",
        "processedAmount": 5,
        "processedCurrency": "USD",
        "status": "SUCCESS",
        "gatewayErrorCode": null,
        "gatewayErrorMsg": null,
        "firstPaymentReferenceId": null,
        "secondPaymentReferenceId": null,
        "properties": null,
        "auditLogs": null
      }
    ],
    "paymentAttempts": null,
    "auditLogs": null
  },
  {
    "targetInvoiceId": "aaf51978-8db2-4858-90b7-e3b0632de3bb",
    "accountId": "9c3f0bea-d1e1-40ae-98bf-81d317885288",
    "paymentId": "685bf6be-17ad-48a3-ae87-a578d0ab1c04",
    "paymentNumber": "349",
    "paymentExternalKey": "f350168c-04ee-47a6-b793-d7c689c1480d",
    "authAmount": 0,
    "capturedAmount": 0,
    "purchasedAmount": 40,
    "refundedAmount": 0,
    "creditedAmount": 0,
    "currency": "USD",
    "paymentMethodId": "569830ae-d246-4daa-8671-ea5f5e6431ea",
    "transactions": [
      {
        "transactionId": "93d561b8-6bca-4328-8fa8-e15473fa631f",
        "transactionExternalKey": "ce4eb15e-2336-4514-afe7-57f4e222f9c3",
        "paymentId": "685bf6be-17ad-48a3-ae87-a578d0ab1c04",
        "paymentExternalKey": "f350168c-04ee-47a6-b793-d7c689c1480d",
        "transactionType": "PURCHASE",
        "amount": 40,
        "currency": "USD",
        "effectiveDate": "2017-03-24T01:18:30.000Z",
        "processedAmount": 40,
        "processedCurrency": "USD",
        "status": "SUCCESS",
        "gatewayErrorCode": null,
        "gatewayErrorMsg": null,
        "firstPaymentReferenceId": null,
        "secondPaymentReferenceId": null,
        "properties": null,
        "auditLogs": null
      }
    ],
    "paymentAttempts": null,
    "auditLogs": null
  }
]
```

GET /rest/v1/invoices/{invoiceId}/payments


### Description
인보이스에 관련된 결제 이력을 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**invoiceId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**withAttempts**  <br>*optional*|boolean|`"false"`|
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [InvoicePaymentJson](#invoicepaymentjson) > array|
|**400**|Invalid invoice id supplied|No Content|
|**404**|Invoice not found|No Content|


### Produces

* `application/json`


<a name="createinvoicetags"></a>
## Add tags to invoice

```
POST /rest/v1/invoices/{invoiceId}/tags

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/invoices/aaf51978-8db2-4858-90b7-e3b0632de3bb/tags?tagList=00000000-0000-0000-0000-000000000004'


Reponse Example

201 Created
```

POST /rest/v1/invoices/{invoiceId}/tags


### Description
인보이스에 태그를 추가한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**invoiceId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid invoice id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getinvoicetags"></a>
## Retrieve invoice tags

```
GET /rest/v1/invoices/{invoiceId}/tags

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/invoices/aaf51978-8db2-4858-90b7-e3b0632de3bb/tags?audit=NONE&includedDeleted=false'


Reponse Example

[
  {
    "tagId": "0da97dbe-49b4-447c-a815-c9993d95eade",
    "objectType": "INVOICE",
    "objectId": "aaf51978-8db2-4858-90b7-e3b0632de3bb",
    "tagDefinitionId": "00000000-0000-0000-0000-000000000004",
    "tagDefinitionName": "WRITTEN_OFF",
    "auditLogs": []
  }
]
```

GET /rest/v1/invoices/{invoiceId}/tags


### Description
인보이스의 태그를 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**invoiceId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**includedDeleted**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [TagJson](#tagjson) > array|
|**400**|Invalid invoice id supplied|No Content|
|**404**|Invoice not found|No Content|


### Produces

* `application/json`


<a name="deleteinvoicetags"></a>
## Remove tags from invoice

```
DELETE /rest/v1/invoices/{invoiceId}/tags

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/invoices/aaf51978-8db2-4858-90b7-e3b0632de3bb/tags?tagList=00000000-0000-0000-0000-000000000004'


Reponse Example

200 DELETED
```

DELETE /rest/v1/invoices/{invoiceId}/tags


### Description
인보이스의 태그를 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**invoiceId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid invoice id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="deletecba"></a>
## Delete a CBA item

```
DELETE /rest/v1/invoices/{invoiceId}/{invoiceItemId}/cba

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/invoices/aaf51978-8db2-4858-90b7-e3b0632de3bb/0da973be-49b4-447c-a815-c9993d95e4de/cba?accountId=9c3f0bea-d1e1-40ae-98bf-81d317885288'



Reponse Example

200 DELETED
```

DELETE /rest/v1/invoices/{invoiceId}/{invoiceItemId}/cba


### Description
인보이스의 가상 화폐(cba) 아이템을 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**invoiceId**  <br>*required*|string|
|**Path**|**invoiceItemId**  <br>*required*|string|
|**Query**|**accountId**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id, invoice id or invoice item id supplied|No Content|
|**404**|Account or invoice not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="notification_resource"></a>
# Notification

<a name="updatenotificationrule"></a>
## Update notification rule

```
POST /rest/v1/notification_config

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "INVOICE": true,
  "SUCCESSFUL_PAYMENT": true,
  "FAILED_PAYMENT": true,
  "SUBSCRIPTION_CANCELLATION_REQUESTED": true,
  "SUBSCRIPTION_CANCELLATION_EFFECTIVE": true,
  "PAYMENT_REFUND": true
}' 
'http://localhost:18080/rest/v1/notification_config'


Reponse Example

201 Created
```

POST /rest/v1/notification_config


### Description
알림 규칙을 업데이트 한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Body**|**body**  <br>*required*|[NotificationRuleJson](#notificationrulejson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|successful operation|No Content|
|**400**|Invalid Request|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getnotificationrule"></a>
## Get notification rule

```
GET /rest/v1/notification_config

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/notification_config'


Reponse Example

{
  "INVOICE": true,
  "SUCCESSFUL_PAYMENT": true,
  "FAILED_PAYMENT": true,
  "SUBSCRIPTION_CANCELLATION_REQUESTED": true,
  "SUBSCRIPTION_CANCELLATION_EFFECTIVE": true,
  "PAYMENT_REFUND": true
}
```

GET /rest/v1/notification_config


### Description
알림 규칙을 조회한다.


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[NotificationRuleJson](#notificationrulejson)|
|**400**|Invalid Request|No Content|


### Produces

* `application/json`


<a name="organization_resource"></a>
# Organization

<a name="createorganization"></a>
## Create organization

```
POST /rest/v1/organization

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
    "name": "sample-organization",
    "fax": "+82100000000",
    "website": "",
    "language_code": "en",
    "time_zone": "+00:00",
    "currency": "USD",
    "is_active": "Y",
    "address1": "inovally C dong",
    "company_name": "unionnec",
    "city": "sungnam",
    "state_or_province": "AL",
    "country": "KR",
    "postal_code": "000-000",
    "phone": "+82100000000"
  }' 'http://localhost:18080/rest/v1/organization'


Reponse Example

201 Created
```

POST /rest/v1/organization


### Description
Organization 을 생성한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Body**|**body**  <br>*required*|[OrganizationJson](#organizationjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|successful operation|No Content|
|**400**|Invalid Request|No Content|
|**409**|Conflict Name|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="listorganization"></a>
## List organizations

```
GET /rest/v1/organization

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/organization'



Reponse Example

[
  {
    "id": "c16ba270-2842-4339-ac35-91c225eaf185",
    "name": "forcs-test-2",
    "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
    "tenant_external_key": "376af2e2-f618-4935-a3a6-99e2dd4003f3",
    "tenant_api_key": "376af2e2-f618-4935-a3a6-99e2dd4003f3",
    "tenant_api_secret": "376af2e2-f618-4935-a3a6-99e2dd4003f3",
    "tenant_api_salt": null,
    "fax": "+82100000000",
    "website": "",
    "language_code": "en",
    "time_zone": "+00:00",
    "date_format": null,
    "currency": "USD",
    "is_active": null,
    "address1": "inovally C dong",
    "address2": null,
    "company_name": "unionnec",
    "city": "sungnam",
    "state_or_province": "AL",
    "country": "KR",
    "postal_code": "000-000",
    "phone": "+82100000000",
    "notes": null,
    "reg_dt": "2017-03-08"
  }
]
```

GET /rest/v1/organization


### Description
사용자가 소유한 organization 목록을 조회한다.


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[OrganizationJson](#organizationjson)|
|**204**|Organization Not Found|No Content|
|**400**|Invalid Request|No Content|


### Produces

* `application/json`


<a name="getorganization"></a>
## Retrieve an Organization by id

```
GET /rest/v1/organization/{organizationId}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/organization/c16ba270-2842-4339-ac35-91c225eaf185'


Reponse Example

{
  "id": "c16ba270-2842-4339-ac35-91c225eaf185",
  "name": "forcs-test-2",
  "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
  "tenant_external_key": "376af2e2-f618-4935-a3a6-99e2dd4003f3",
  "tenant_api_key": "376af2e2-f618-4935-a3a6-99e2dd4003f3",
  "tenant_api_secret": "376af2e2-f618-4935-a3a6-99e2dd4003f3",
  "tenant_api_salt": null,
  "fax": "+82100000000",
  "website": "",
  "language_code": "en",
  "time_zone": "+00:00",
  "date_format": null,
  "currency": "USD",
  "is_active": null,
  "address1": "inovally C dong",
  "address2": null,
  "company_name": "unionnec",
  "city": "sungnam",
  "state_or_province": "AL",
  "country": "KR",
  "postal_code": "000-000",
  "phone": "+82100000000",
  "notes": null,
  "reg_dt": "2017-03-08"
}
```

GET /rest/v1/organization/{organizationId}


### Description
organization 을 아이디로 조회한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**organizationId**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[OrganizationJson](#organizationjson)|
|**400**|Invalid organization id supplied|No Content|
|**404**|Organization not found|No Content|


### Produces

* `application/json`


<a name="updateorganization"></a>
## Update Organization

```
PUT /rest/v1/organization/{organizationId}

Request Example

curl -X PUT 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "name": "forcs-test-2",
  "fax": "+82100000000",
  "website": "",
  "language_code": "en",
  "time_zone": "+00:00",
  "currency": "USD",
  "address1": "inovally C dong",
  "company_name": "unionnec",
  "city": "sungnam",
  "state_or_province": "AL",
  "country": "KR",
  "postal_code": "000-000",
  "phone": "+82100000000"
}' 
'http://localhost:18080/rest/v1/organization/c16ba270-2842-4339-ac35-91c225eaf185'


Reponse Example

{
  "id": "c16ba270-2842-4339-ac35-91c225eaf185",
  "name": "forcs-test-2",
  "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
  "tenant_external_key": "376af2e2-f618-4935-a3a6-99e2dd4003f3",
  "tenant_api_key": "376af2e2-f618-4935-a3a6-99e2dd4003f3",
  "tenant_api_secret": "376af2e2-f618-4935-a3a6-99e2dd4003f3",
  "tenant_api_salt": null,
  "fax": "+82100000000",
  "website": "",
  "language_code": "en",
  "time_zone": "+00:00",
  "date_format": null,
  "currency": "USD",
  "is_active": null,
  "address1": "inovally C dong",
  "address2": null,
  "company_name": "unionnec",
  "city": "sungnam",
  "state_or_province": "AL",
  "country": "KR",
  "postal_code": "000-000",
  "phone": "+82100000000",
  "notes": null,
  "reg_dt": "2017-03-08"
}
```

PUT /rest/v1/organization/{organizationId}


### Description
Organization 정보를 업데이트한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**organizationId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|[OrganizationJson](#organizationjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[OrganizationJson](#organizationjson)|
|**400**|Invalid organization data supplied|No Content|
|**404**|Organization not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="deleteorganization"></a>
## Remove organization

```
DELETE /rest/v1/organization/{organizationId}

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/organization/d08f76fa-9147-489b-ab29-f0d4b28efeea'


Reponse Example

204 no content
```

DELETE /rest/v1/organization/{organizationId}


### Description
organization 을 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**organizationId**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|successful operation|No Content|
|**400**|Invalid organization id supplied|No Content|
|**404**|Organization not found|No Content|


### Produces

* `application/json`


<a name="createorganizationemail"></a>
## Create organizationEmail

```
POST /rest/v1/organizationEmail

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
   "email": "darkgodarkgo2@gmail.com"
}' 
'http://localhost:18080/rest/v1/organizationEmail'


Reponse Example

201 Created
```

POST /rest/v1/organizationEmail


### Description
Organization email 을 생성한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Body**|**body**  <br>*required*|[OrganizationEmailJson](#organizationemailjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|successful operation|No Content|
|**400**|Invalid Request|No Content|
|**409**|Conflict Email|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="listorganizationemail"></a>
## List organizationEmail

```
GET /rest/v1/organizationEmail

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/organizationEmail'


Reponse Example

[
  {
    "id": "6050744c-0aac-4409-a8f0-de16e2396906",
    "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
    "email": "darkgodarkgo2@gmail.com",
    "is_active": "Y",
    "is_default": "N",
    "reg_dt": "2017-03-24"
  },
  {
    "id": "b7e1d07d-3d22-46b2-a453-23e6ce171948",
    "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
    "email": "darkgodarkgo@gmail.com",
    "is_active": "Y",
    "is_default": "Y",
    "reg_dt": "2017-03-08"
  }
]
```

GET /rest/v1/organizationEmail


### Description
사용자가 소유한 organization email 목록을 조회한다.


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[OrganizationEmailJson](#organizationemailjson)|
|**204**|Organization Not Found|No Content|
|**400**|Invalid Request|No Content|


### Produces

* `application/json`


<a name="updateorganizationemail"></a>
## Update Organization Email

```
PUT /rest/v1/organizationEmail/{organizationEmailId}

Request Example

curl -X PUT 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "email": "darkgodarkgo3@gmail.com",
   "is_active": "Y"
}' 
'http://localhost:18080/rest/v1/organizationEmail/6050744c-0aac-4409-a8f0-de16e2396906'


Reponse Example

{
  "id": "6050744c-0aac-4409-a8f0-de16e2396906",
  "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
  "email": "darkgodarkgo3@gmail.com",
  "is_active": "Y",
  "is_default": "N",
  "reg_dt": "2017-03-24"
}
```

PUT /rest/v1/organizationEmail/{organizationEmailId}


### Description
Organization Email 정보를 업데이트한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**organizationEmailId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|[OrganizationEmailJson](#organizationemailjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[OrganizationEmailJson](#organizationemailjson)|
|**400**|Invalid organization email data supplied|No Content|
|**404**|Organization email not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="deleteorganizationemail"></a>
## Remove organization email

```
DELETE /rest/v1/organizationEmail/{organizationEmailId}

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/organizationEmail/6050744c-0aac-4409-a8f0-de16e2396906'


Reponse Example

204 no content
```

DELETE /rest/v1/organizationEmail/{organizationEmailId}


### Description
organization email 을 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**organizationEmailId**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|successful operation|No Content|
|**400**|Invalid organization email id supplied|No Content|
|**404**|Organization email not found|No Content|


### Produces

* `application/json`



<a name="getorganizationsales"></a>
## List organization sales history
```
GET /rest/v1/organization/sales/pagination

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: 6925a6d1-a6b7-4298-944b-b29945bd4872' 
'http://localhost:18080/rest/v1/organization/sales/pagination?offset=0&limit=1'


Response Example

[
  {
    "record_id": 256,
    "subscription_id": "49c5c928-110f-461f-93f0-2d82a7d27a51",
    "tenant_id": "a31a66e0-ed86-494c-983a-75df5894069d",
    "organization_id": "6925a6d1-a6b7-4298-944b-b29945bd4872",
    "buyer_id": "2fe21dcf-d5ec-4ce2-b55e-922d5e3f4183",
    "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3",
    "product_id": "PRD_0000000002",
    "version": 1,
    "plan_name": "PRD_0000000002_PL_000001",
    "usage_name": null,
    "ratio": 30,
    "amount": 1.5,
    "original_amount": 5,
    "currency": "USD",
    "invoice_id": "08363881-445e-4431-aa1e-9838b95defbd",
    "invoice_item_id": "63f5363f-3d4c-45f8-a5ee-4c025f04a382",
    "linked_invoice_item_id": null,
    "invoice_item_type": "RECURRING",
    "price_type": "RECURRING",
    "transaction_type": "CREATION",
    "format_date": "2017-12-20",
    "created_date": "2017-06-30",
    "notes": "Bds"
  }
]
```


### Description
조직의 판매 이력을 페이징 처리하여 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [ProductDistributionHistory](#productdistributionhistory) > array|


### Produces

* `application/json`


<a name="searchorganizationsales"></a>
## Search organization sales history
```
GET /rest/v1/organization/sales/search/{searchKey}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: 6925a6d1-a6b7-4298-944b-b29945bd4872' 
'http://localhost:18080/rest/v1/organization/sales/search/08363881-445e-4431-aa1e-9838b95defbd?offset=0&limit=1'


Response Example

[
  {
    "record_id": 256,
    "subscription_id": "49c5c928-110f-461f-93f0-2d82a7d27a51",
    "tenant_id": "a31a66e0-ed86-494c-983a-75df5894069d",
    "organization_id": "6925a6d1-a6b7-4298-944b-b29945bd4872",
    "buyer_id": "2fe21dcf-d5ec-4ce2-b55e-922d5e3f4183",
    "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3",
    "product_id": "PRD_0000000002",
    "version": 1,
    "plan_name": "PRD_0000000002_PL_000001",
    "usage_name": null,
    "ratio": 30,
    "amount": 1.5,
    "original_amount": 5,
    "currency": "USD",
    "invoice_id": "08363881-445e-4431-aa1e-9838b95defbd",
    "invoice_item_id": "63f5363f-3d4c-45f8-a5ee-4c025f04a382",
    "linked_invoice_item_id": null,
    "invoice_item_type": "RECURRING",
    "price_type": "RECURRING",
    "transaction_type": "CREATION",
    "format_date": "2017-12-20",
    "created_date": "2017-06-30",
    "notes": "Bds"
  }
]
```


### Description
주어진 검색어에 해당하는 조직의 판매 이력을 페이징 처리하여 반환한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**searchKey**  <br>*required*|string||
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [ProductDistributionHistory](#productdistributionhistory) > array|


### Produces

* `application/json`


<a name="getorganizationsalessummary"></a>
## get organization sales summary per date
```
GET /rest/v1/organization/sales/summary

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: 6925a6d1-a6b7-4298-944b-b29945bd4872' 
'http://localhost:18080/rest/v1/organization/sales/summary?period=MONTH&start_date=2017-01-01&end_date=2017-12-31'


Response Example

{
  "total_revenue": {
    "refund": {
      "summary": {
        "total": {
          "USD": -36,
          "KRW": -9000
        },
        "per_usage_name": {},
        "per_vendor_id": {},
        "per_product_id": {},
        "per_plan_name": {},
        "per_price_type": {
          "USAGE": {
            "USD": -10,
            "KRW": -3000
          },
          "RECURRING": {
            "USD": -16,
            "KRW": -6000
          },
          "ONE_TIME": {
            "USD": -10
          }
        }
      },
      "per_date": {
        "2017-06": [
          {
            "amount": {
              "USD": -10
            },
            "price_type": "ONE_TIME"
          }
        ],
        "2017-08": [
          {
            "amount": {
              "USD": -16,
              "KRW": -6000
            },
            "price_type": "RECURRING"
          },
          {
            "amount": {
              "USD": -10,
              "KRW": -3000
            },
            "price_type": "USAGE"
          }
        ]
      }
    },
    "credit": {
      "summary": {
        "total": {},
        "per_usage_name": {},
        "per_vendor_id": {},
        "per_product_id": {},
        "per_plan_name": {},
        "per_price_type": {}
      },
      "per_date": {}
    },
    "end_date": "2017-12-31",
    "withdraw": {
      "summary": {
        "total": {
          "USD": -11
        },
        "per_usage_name": {},
        "per_vendor_id": {},
        "per_product_id": {},
        "per_plan_name": {},
        "per_price_type": {}
      },
      "per_date": {
        "2017-07": [
          {
            "amount": {
              "USD": -11
            },
            "price_type": ""
          }
        ]
      }
    },
    "sales": {
      "summary": {
        "total": {
          "USD": 1393.7,
          "KRW": 139000
        },
        "per_usage_name": {},
        "per_vendor_id": {},
        "per_product_id": {},
        "per_plan_name": {},
        "per_price_type": {
          "USAGE": {
            "USD": 46,
            "KRW": 34000
          },
          "RECURRING": {
            "USD": 922.7,
            "KRW": 105000
          },
          "ONE_TIME": {
            "USD": 410
          },
          "FIXED": {
            "USD": 15
          }
        }
      },
      "per_date": {
        "2017-06": [
          {
            "amount": {
              "USD": 132.33,
              "KRW": 15000
            },
            "price_type": "RECURRING"
          },
          {
            "amount": {
              "USD": 0
            },
            "price_type": "FIXED"
          },
          {
            "amount": {
              "USD": 130
            },
            "price_type": "ONE_TIME"
          }
        ],
        "2017-10": [
          {
            "amount": {
              "USD": 63,
              "KRW": 15000
            },
            "price_type": "RECURRING"
          },
          {
            "amount": {
              "USD": 10
            },
            "price_type": "FIXED"
          }
        ],
        "2017-11": [
          {
            "amount": {
              "USD": 53,
              "KRW": 15000
            },
            "price_type": "RECURRING"
          }
        ],
        "2017-12": [
          {
            "amount": {
              "USD": 103,
              "KRW": 15000
            },
            "price_type": "RECURRING"
          }
        ],
        "2017-07": [
          {
            "amount": {
              "USD": 5
            },
            "price_type": "FIXED"
          },
          {
            "amount": {
              "USD": 219.28
            },
            "price_type": "RECURRING"
          },
          {
            "amount": {
              "USD": 20
            },
            "price_type": "ONE_TIME"
          }
        ],
        "2017-08": [
          {
            "amount": {
              "USD": 232.75,
              "KRW": 30000
            },
            "price_type": "RECURRING"
          },
          {
            "amount": {
              "USD": 46,
              "KRW": 34000
            },
            "price_type": "USAGE"
          },
          {
            "amount": {
              "USD": 230
            },
            "price_type": "ONE_TIME"
          }
        ],
        "2017-09": [
          {
            "amount": {
              "USD": 119.34,
              "KRW": 15000
            },
            "price_type": "RECURRING"
          },
          {
            "amount": {
              "USD": 30
            },
            "price_type": "ONE_TIME"
          }
        ]
      }
    },
    "start_date": "2017-01-01",
    "currencies": [
      "KRW",
      "USD"
    ]
  },
  "end_date": "2017-12-31",
  "start_date": "2017-01-01",
  "currencies": [
    "KRW",
    "USD"
  ],
  "net_summary": {
    "refund": {
      "summary": {
        "total": {
          "USD": -28.0868,
          "KRW": -7338.4
        },
        "per_usage_name": {},
        "per_vendor_id": {},
        "per_product_id": {},
        "per_plan_name": {},
        "per_price_type": {
          "USAGE": {
            "USD": -9.336,
            "KRW": -2800.8
          },
          "RECURRING": {
            "USD": -12.3528,
            "KRW": -4537.6
          },
          "ONE_TIME": {
            "USD": -6.398
          }
        }
      },
      "per_date": {
        "2017-06": [
          {
            "amount": {
              "USD": -6.398
            },
            "price_type": "ONE_TIME"
          }
        ],
        "2017-08": [
          {
            "amount": {
              "USD": -12.3528,
              "KRW": -4537.6
            },
            "price_type": "RECURRING"
          },
          {
            "amount": {
              "USD": -9.336,
              "KRW": -2800.8
            },
            "price_type": "USAGE"
          }
        ]
      }
    },
    "credit": {
      "summary": {
        "total": {},
        "per_usage_name": {},
        "per_vendor_id": {},
        "per_product_id": {},
        "per_plan_name": {},
        "per_price_type": {}
      },
      "per_date": {}
    },
    "end_date": "2017-12-31",
    "withdraw": {
      "summary": {
        "total": {
          "USD": -11
        },
        "per_usage_name": {},
        "per_vendor_id": {},
        "per_product_id": {},
        "per_plan_name": {},
        "per_price_type": {}
      },
      "per_date": {
        "2017-07": [
          {
            "amount": {
              "USD": -11
            },
            "price_type": ""
          }
        ]
      }
    },
    "sales": {
      "summary": {
        "total": {
          "USD": 1152.939686,
          "KRW": 111150.4
        },
        "per_usage_name": {},
        "per_vendor_id": {},
        "per_product_id": {},
        "per_plan_name": {},
        "per_price_type": {
          "USAGE": {
            "USD": 42.9456,
            "KRW": 31742.4
          },
          "RECURRING": {
            "USD": 720.218086,
            "KRW": 79408
          },
          "ONE_TIME": {
            "USD": 377.582
          },
          "FIXED": {
            "USD": 12.194
          }
        }
      },
      "per_date": {
        "2017-06": [
          {
            "amount": {
              "USD": 105.7171,
              "KRW": 11344
            },
            "price_type": "RECURRING"
          },
          {
            "amount": {
              "USD": 0
            },
            "price_type": "FIXED"
          },
          {
            "amount": {
              "USD": 122.796
            },
            "price_type": "ONE_TIME"
          }
        ],
        "2017-10": [
          {
            "amount": {
              "USD": 49.282,
              "KRW": 11344
            },
            "price_type": "RECURRING"
          },
          {
            "amount": {
              "USD": 8.194
            },
            "price_type": "FIXED"
          }
        ],
        "2017-11": [
          {
            "amount": {
              "USD": 41.088,
              "KRW": 11344
            },
            "price_type": "RECURRING"
          }
        ],
        "2017-12": [
          {
            "amount": {
              "USD": 82.058,
              "KRW": 11344
            },
            "price_type": "RECURRING"
          }
        ],
        "2017-07": [
          {
            "amount": {
              "USD": 4
            },
            "price_type": "FIXED"
          },
          {
            "amount": {
              "USD": 168.124902
            },
            "price_type": "RECURRING"
          },
          {
            "amount": {
              "USD": 16.398
            },
            "price_type": "ONE_TIME"
          }
        ],
        "2017-08": [
          {
            "amount": {
              "USD": 180.336888,
              "KRW": 22688
            },
            "price_type": "RECURRING"
          },
          {
            "amount": {
              "USD": 42.9456,
              "KRW": 31742.4
            },
            "price_type": "USAGE"
          },
          {
            "amount": {
              "USD": 219.194
            },
            "price_type": "ONE_TIME"
          }
        ],
        "2017-09": [
          {
            "amount": {
              "USD": 93.611196,
              "KRW": 11344
            },
            "price_type": "RECURRING"
          },
          {
            "amount": {
              "USD": 19.194
            },
            "price_type": "ONE_TIME"
          }
        ]
      }
    },
    "start_date": "2017-01-01",
    "currencies": [
      "KRW",
      "USD"
    ]
  }
}
```


### Description
조직의 판매대금 합계를 기간별로 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**end_date**  <br>*optional*|string||
|**Query**|**period**  <br>*optional*|enum (DAY, MONTH, YEAR)|`"DAY"`|
|**Query**|**plan_name**  <br>*optional*|string||
|**Query**|**product_id**  <br>*optional*|string||
|**Query**|**start_date**  <br>*optional*|string||
|**Query**|**usage_name**  <br>*optional*|string||
|**Query**|**vendor_id**  <br>*optional*|string||


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[OrganizationSalesPerDateSummaryJson](#organizationsalesperdatesummaryjson)|
|**400**|Invalid request supplied|No Content|
|**404**|Not found|No Content|


### Produces

* `application/json`


<a name="overdue_resource"></a>
# Overdue

<a name="uploadoverdueconfigjson"></a>
## Upload the full overdue config as JSON

```
POST /rest/v1/overdue

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "initialReevaluationInterval": 30,
  "overdueStates": [
    {
      "name": "OD3",
      "isClearState": false,
      "condition": {
        "timeSinceEarliestUnpaidInvoiceEqualsOrExceeds": {
          "unit": "DAYS",
          "number": 50
        },
        "controlTagInclusion": null,
        "controlTagExclusion": null,
        "numberOfUnpaidInvoicesEqualsOrExceeds": null,
        "responseForLastFailedPayment": null,
        "totalUnpaidInvoiceBalanceEqualsOrExceeds": null
      },
      "externalMessage": "Reached OD3",
      "blockChanges": true,
      "disableEntitlement": true,
      "subscriptionCancellationPolicy": "NONE",
      "autoReevaluationIntervalDays": 5
    },
    {
      "name": "OD2",
      "isClearState": false,
      "condition": {
        "timeSinceEarliestUnpaidInvoiceEqualsOrExceeds": {
          "unit": "DAYS",
          "number": 40
        },
        "controlTagInclusion": null,
        "controlTagExclusion": null,
        "numberOfUnpaidInvoicesEqualsOrExceeds": null,
        "responseForLastFailedPayment": null,
        "totalUnpaidInvoiceBalanceEqualsOrExceeds": null
      },
      "externalMessage": "Reached OD2",
      "blockChanges": true,
      "disableEntitlement": true,
      "subscriptionCancellationPolicy": "NONE",
      "autoReevaluationIntervalDays": 5
    },
    {
      "name": "OD1",
      "isClearState": false,
      "condition": {
        "timeSinceEarliestUnpaidInvoiceEqualsOrExceeds": {
          "unit": "DAYS",
          "number": 30
        },
        "controlTagInclusion": null,
        "controlTagExclusion": null,
        "numberOfUnpaidInvoicesEqualsOrExceeds": null,
        "responseForLastFailedPayment": null,
        "totalUnpaidInvoiceBalanceEqualsOrExceeds": null
      },
      "externalMessage": "Reached OD1",
      "blockChanges": true,
      "disableEntitlement": false,
      "subscriptionCancellationPolicy": "NONE",
      "autoReevaluationIntervalDays": 5
    }
  ]
}' 
'http://localhost:18080/rest/v1/overdue'


Reponse Example

201 Created
```

POST /rest/v1/overdue


### Description
조직의 연체 규칙을 갱신한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Body**|**body**  <br>*optional*|[OverdueJson](#overduejson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**default**|successful operation|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getoverdueconfigjson"></a>
## Retrieve the overdue config as JSON

```
GET /rest/v1/overdue

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/overdue'


Reponse Example

{
  "initialReevaluationInterval": 30,
  "overdueStates": [
    {
      "name": "OD3",
      "isClearState": false,
      "condition": {
        "timeSinceEarliestUnpaidInvoiceEqualsOrExceeds": {
          "unit": "DAYS",
          "number": 50
        },
        "controlTagInclusion": null,
        "controlTagExclusion": null,
        "numberOfUnpaidInvoicesEqualsOrExceeds": null,
        "responseForLastFailedPayment": null,
        "totalUnpaidInvoiceBalanceEqualsOrExceeds": null
      },
      "externalMessage": "Reached OD3",
      "blockChanges": true,
      "disableEntitlement": true,
      "subscriptionCancellationPolicy": "NONE",
      "autoReevaluationIntervalDays": 5
    },
    {
      "name": "OD2",
      "isClearState": false,
      "condition": {
        "timeSinceEarliestUnpaidInvoiceEqualsOrExceeds": {
          "unit": "DAYS",
          "number": 40
        },
        "controlTagInclusion": null,
        "controlTagExclusion": null,
        "numberOfUnpaidInvoicesEqualsOrExceeds": null,
        "responseForLastFailedPayment": null,
        "totalUnpaidInvoiceBalanceEqualsOrExceeds": null
      },
      "externalMessage": "Reached OD2",
      "blockChanges": true,
      "disableEntitlement": true,
      "subscriptionCancellationPolicy": "NONE",
      "autoReevaluationIntervalDays": 5
    },
    {
      "name": "OD1",
      "isClearState": false,
      "condition": {
        "timeSinceEarliestUnpaidInvoiceEqualsOrExceeds": {
          "unit": "DAYS",
          "number": 30
        },
        "controlTagInclusion": null,
        "controlTagExclusion": null,
        "numberOfUnpaidInvoicesEqualsOrExceeds": null,
        "responseForLastFailedPayment": null,
        "totalUnpaidInvoiceBalanceEqualsOrExceeds": null
      },
      "externalMessage": "Reached OD1",
      "blockChanges": true,
      "disableEntitlement": false,
      "subscriptionCancellationPolicy": "NONE",
      "autoReevaluationIntervalDays": 5
    }
  ]
}
```

GET /rest/v1/overdue


### Description
조직의 연체 규칙을 조회한다.


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[OverdueJson](#overduejson)|


### Produces

* `application/json`


<a name="paymentmethods_resource"></a>
# PaymentMethods

<a name="getpaymentmethodbykey"></a>
## Retrieve a payment method by external key

```
GET /rest/v1/paymentMethods

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/paymentMethods?externalKey=B-75L12802X57945620&audit=NONE&withPluginInfo=false'


Reponse Example

{
  "paymentMethodId": "32cdf8e8-cef1-4995-afcb-ac16eefe7672",
  "externalKey": "B-75L12802X57945620",
  "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
  "isDefault": true,
  "pluginName": "killbill-paypal-express",
  "pluginInfo": null,
  "auditLogs": []
}
```

GET /rest/v1/paymentMethods


### Description
external key 로 결제 수단을 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**externalKey**  <br>*optional*|string||
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[PaymentMethodJson](#paymentmethodjson)|
|**404**|Account or payment method not found|No Content|


### Produces

* `application/json`


<a name="getpaymentmethods"></a>
## List payment methods

```
GET /rest/v1/paymentMethods/pagination

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/paymentMethods/pagination?offset=0&limit=100&audit=NONE&withPluginInfo=false'


Reponse Example

[
  {
    "paymentMethodId": "49a563b1-4b8b-4a3b-b214-a09c4c19a0d2",
    "externalKey": "unknown",
    "accountId": "8c3d99ff-1659-4153-917e-f4f27172f92d",
    "isDefault": true,
    "pluginName": "__EXTERNAL_PAYMENT__",
    "pluginInfo": null,
    "auditLogs": []
  },
  {
    "paymentMethodId": "3abc15e4-5471-4f1c-92aa-295a7481fe26",
    "externalKey": "B-7P9004527M6019431",
    "accountId": "7af010f0-1fb3-413d-a133-3b463f0cc79e",
    "isDefault": true,
    "pluginName": "killbill-paypal-express",
    "pluginInfo": null,
    "auditLogs": []
  }
]
```

GET /rest/v1/paymentMethods/pagination


### Description
결제 수단을 페이징 하여 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|
|**Query**|**pluginName**  <br>*optional*|string||
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [PaymentMethodJson](#paymentmethodjson) > array|


### Produces

* `application/json`


<a name="searchpaymentmethods"></a>
## Search payment methods

```
GET /rest/v1/paymentMethods/search/{searchKey}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/paymentMethods/search/paypal?offset=0&limit=100&audit=NONE&withPluginInfo=false'


Reponse Example

[
  {
    "paymentMethodId": "32cdf8e8-cef1-4995-afcb-ac16eefe7672",
    "externalKey": "B-75L12802X57945620",
    "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
    "isDefault": true,
    "pluginName": "killbill-paypal-express",
    "pluginInfo": null,
    "auditLogs": []
  },
  {
    "paymentMethodId": "3abc15e4-5471-4f1c-92aa-295a7481fe26",
    "externalKey": "B-7P9004527M6019431",
    "accountId": "7af010f0-1fb3-413d-a133-3b463f0cc79e",
    "isDefault": true,
    "pluginName": "killbill-paypal-express",
    "pluginInfo": null,
    "auditLogs": []
  }
]
```

GET /rest/v1/paymentMethods/search/{searchKey}


### Description
주어진 검색어로 결제 수단을 페이징 하여 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**searchKey**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|
|**Query**|**pluginName**  <br>*optional*|string||
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [PaymentMethodJson](#paymentmethodjson) > array|


### Produces

* `application/json`


<a name="getpaymentmethod"></a>
## Retrieve a payment method by id

```
GET /rest/v1/paymentMethods/{paymentMethodId}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/paymentMethods/32cdf8e8-cef1-4995-afcb-ac16eefe7672?audit=NONE&withPluginInfo=true'


Reponse Example

{
  "paymentMethodId": "32cdf8e8-cef1-4995-afcb-ac16eefe7672",
  "externalKey": "B-75L12802X57945620",
  "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
  "isDefault": true,
  "pluginName": "killbill-paypal-express",
  "pluginInfo": {
    "externalPaymentMethodId": "B-75L12802X57945620",
    "isDefaultPaymentMethod": false,
    "properties": [
      {
        "key": "token",
        "value": "B-75L12802X57945620",
        "isUpdatable": false
      },
      {
        "key": "ccFirstName",
        "value": null,
        "isUpdatable": false
      },
      {
        "key": "ccLastName",
        "value": null,
        "isUpdatable": false
      },
      {
        "key": "ccName",
        "value": null,
        "isUpdatable": false
      },
      {
        "key": "ccType",
        "value": null,
        "isUpdatable": false
      },
      {
        "key": "ccExpirationMonth",
        "value": null,
        "isUpdatable": false
      },
      {
        "key": "ccExpirationYear",
        "value": null,
        "isUpdatable": false
      },
      {
        "key": "ccLast4",
        "value": null,
        "isUpdatable": false
      },
      {
        "key": "ccNumber",
        "value": null,
        "isUpdatable": false
      },
      {
        "key": "address1",
        "value": null,
        "isUpdatable": false
      },
      {
        "key": "address2",
        "value": null,
        "isUpdatable": false
      },
      {
        "key": "city",
        "value": null,
        "isUpdatable": false
      },
      {
        "key": "state",
        "value": null,
        "isUpdatable": false
      },
      {
        "key": "zip",
        "value": null,
        "isUpdatable": false
      },
      {
        "key": "country",
        "value": null,
        "isUpdatable": false
      },
      {
        "key": "paypalExpressToken",
        "value": "EC-04T525946L128730M",
        "isUpdatable": false
      },
      {
        "key": "payerId",
        "value": "D8GEWYW4CJV58",
        "isUpdatable": false
      },
      {
        "key": "baid",
        "value": "B-75L12802X57945620",
        "isUpdatable": false
      }
    ]
  },
  "auditLogs": []
}
```

GET /rest/v1/paymentMethods/{paymentMethodId}


### Description
아이디로 결제 수단을 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**paymentMethodId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[PaymentMethodJson](#paymentmethodjson)|
|**400**|Invalid paymentMethodId supplied|No Content|
|**404**|Account or payment method not found|No Content|


### Produces

* `application/json`


<a name="deletepaymentmethod"></a>
## Delete a payment method

```
DELETE /rest/v1/paymentMethods/{paymentMethodId}

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/paymentMethods/906991de-2f46-4b64-9da0-ec24b274e643?deleteDefaultPmWithAutoPayOff=false&forceDefaultPmDeletion=false'


Reponse Example

200 DELETED
```

DELETE /rest/v1/paymentMethods/{paymentMethodId}


### Description
결제 수단을 삭제한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string||
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string||
|**Header**|**X-Killbill-Reason**  <br>*optional*|string||
|**Path**|**paymentMethodId**  <br>*required*|string||
|**Query**|**deleteDefaultPmWithAutoPayOff**  <br>*optional*|boolean|`"false"`|
|**Query**|**forceDefaultPmDeletion**  <br>*optional*|boolean|`"false"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid paymentMethodId supplied|No Content|
|**404**|Account or payment method not found|No Content|


### Produces

* `application/json`


<a name="createpaymentmethodcustomfields"></a>
## Add custom fields to payment method

```
POST /rest/v1/paymentMethods/{paymentMethodId}/customFields

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '[
  {
    "name": "key1",
    "value": "value1"
  }
]' 
'http://localhost:18080/rest/v1/paymentMethods/32cdf8e8-cef1-4995-afcb-ac16eefe7672/customFields'


Reponse Example

201 Created
```

POST /rest/v1/paymentMethods/{paymentMethodId}/customFields


### Description
결제 수단에 커스텀 필드를 추가한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentMethodId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|< [CustomFieldJson](#customfieldjson) > array|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment method id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getpaymentmethodcustomfields"></a>
## Retrieve payment method custom fields

```
GET /rest/v1/paymentMethods/{paymentMethodId}/customFields

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/paymentMethods/32cdf8e8-cef1-4995-afcb-ac16eefe7672/customFields?audit=NONE'



Reponse Example

200 OK
```

GET /rest/v1/paymentMethods/{paymentMethodId}/customFields


### Description
결제 수단의 커스텀 필드를 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**paymentMethodId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [CustomFieldJson](#customfieldjson) > array|
|**400**|Invalid payment method id supplied|No Content|


### Produces

* `application/json`


<a name="deletepaymentmethodcustomfields"></a>
## Remove custom fields from payment method

```
DELETE /rest/v1/paymentMethods/{paymentMethodId}/customFields

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/paymentMethods/32cdf8e8-cef1-4995-afcb-ac16eefe7672/customFields?customFieldList=4b88735c-ec07-47ec-9c66-99f16eacbade'


Reponse Example

200 DELETED
```

DELETE /rest/v1/paymentMethods/{paymentMethodId}/customFields


### Description
결제 수단의 커스텀 필드를 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentMethodId**  <br>*required*|string|
|**Query**|**customFieldList**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment method id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="paymenttransactions_resource"></a>
# PaymentTransactions

<a name="notifystatechanged"></a>
## Mark a pending payment transaction as succeeded or failed

```
POST /rest/v1/paymentTransactions/{transactionId}

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
"paymentId": "4457d882-a012-49ea-93e3-6b3f6997fb51",
  "status": "SUCCESS"
}' 
'http://localhost:18080/rest/v1/paymentTransactions/a87081e1-643a-4aae-a5f3-c16f124b68de'


Reponse Example

200 OK
```

POST /rest/v1/paymentTransactions/{transactionId}


### Description
Pending 상태인 결제 트랜잭션을 succeeded 또는 failed 상태로 변경한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**transactionId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid paymentId supplied|No Content|
|**404**|Account or Payment not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="createpaymenttransactioncustomfields"></a>
## Add custom fields to payment transaction

```
POST /rest/v1/paymentTransactions/{transactionId}/customFields

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '[
  {
    "name": "key1",
    "value": "value1"
  }
]' 
'http://localhost:18080/rest/v1/paymentTransactions/a87081e1-643a-4aae-a5f3-c16f124b68de/customFields'


Reponse Example

201 Created
```

POST /rest/v1/paymentTransactions/{transactionId}/customFields


### Description
결제 트랜잭션에 커스텀 필드를 추가한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**transactionId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|< [CustomFieldJson](#customfieldjson) > array|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid transaction id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getpaymenttransactioncustomfields"></a>
## Retrieve payment transaction custom fields

```
GET /rest/v1/paymentTransactions/{transactionId}/customFields

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/paymentTransactions/a87081e1-643a-4aae-a5f3-c16f124b68de/customFields?audit=NONE'


Reponse Example

[
  {
    "customFieldId": "f59125c2-1f3e-46bf-9eec-06acdc8c8f67",
    "objectId": "a87081e1-643a-4aae-a5f3-c16f124b68de",
    "objectType": "TRANSACTION",
    "name": "key1",
    "value": "value1",
    "auditLogs": []
  }
]
```

GET /rest/v1/paymentTransactions/{transactionId}/customFields


### Description
결제 트랜잭션의 커스텀 필드를 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**transactionId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [CustomFieldJson](#customfieldjson) > array|
|**400**|Invalid transaction id supplied|No Content|


### Produces

* `application/json`


<a name="deletepaymenttransactioncustomfields"></a>
## Remove custom fields from payment transaction

```
DELETE /rest/v1/paymentTransactions/{transactionId}/customFields

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/paymentTransactions/a87081e1-643a-4aae-a5f3-c16f124b68de/customFields?customFieldList=f59125c2-1f3e-46bf-9eec-06acdc8c8f67'


Reponse Example

200 DELETED
```

DELETE /rest/v1/paymentTransactions/{transactionId}/customFields


### Description
결제 트랜잭션의 커스텀 필드를 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**transactionId**  <br>*required*|string|
|**Query**|**customFieldList**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid transaction id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="createpaymenttransactiontags"></a>
## Add tags to payment transaction

```
POST /rest/v1/paymentTransactions/{transactionId}/tags

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/paymentTransactions/a87081e1-643a-4aae-a5f3-c16f124b68de/tags?tagList=00000000-0000-0000-0000-000000000001'


Reponse Example

201 Created
```

POST /rest/v1/paymentTransactions/{transactionId}/tags


### Description
결제 트랜잭션에 태그를 추가한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**transactionId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid transaction id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getpaymenttransactiontags"></a>
## Retrieve payment transaction tags

```
GET /rest/v1/paymentTransactions/{transactionId}/tags

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/paymentTransactions/a87081e1-643a-4aae-a5f3-c16f124b68de/tags?audit=NONE&includedDeleted=false'


Reponse Example

[
  {
    "tagId": "c5894e75-c368-40c7-9f42-0342ac943a76",
    "objectType": "TRANSACTION",
    "objectId": "a87081e1-643a-4aae-a5f3-c16f124b68de",
    "tagDefinitionId": "00000000-0000-0000-0000-000000000001",
    "tagDefinitionName": "AUTO_PAY_OFF",
    "auditLogs": []
  }
]
```

GET /rest/v1/paymentTransactions/{transactionId}/tags


### Description
결제 트랜잭션의 태그를 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**transactionId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**includedDeleted**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [TagJson](#tagjson) > array|
|**400**|Invalid transaction id supplied|No Content|
|**404**|Invoice not found|No Content|


### Produces

* `application/json`


<a name="deletepaymenttransactiontags"></a>
## Remove tags from payment transaction

```
DELETE /rest/v1/paymentTransactions/{transactionId}/tags

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/paymentTransactions/a87081e1-643a-4aae-a5f3-c16f124b68de/tags?tagList=00000000-0000-0000-0000-000000000001'


Reponse Example

200 DELETED
```

DELETE /rest/v1/paymentTransactions/{transactionId}/tags


### Description
결제 트랜잭션에 태그를 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**transactionId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid transaction id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="payments_resource"></a>
# Payments

<a name="captureauthorizationbyexternalkey"></a>
## Capture an existing authorization

```
POST /rest/v1/payments

Request Example

여기서부터 curl 바꾸기

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "paymentExternalKey": "c2f4966d-c944-4086-a7b7-4759b5d31913",
  "amount": 20,
  "currency": "USD"
}' 
'http://localhost:18080/rest/v1/payments'


Reponse Example

201 Created
```

POST /rest/v1/payments


### Description
paymentExternalKey 사용. PG 사를 통해 Authorization (결제 승인 대기) 중인 결제 이력에 대해, 결제 확인을 한다. 이후 PG 사에서 판매자(조직) 의 구좌에 입금처리가 완료된다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|Payment transaction created successfully|No Content|
|**402**|Transaction declined by gateway|No Content|
|**404**|Account or payment not found|No Content|
|**422**|Payment is aborted by a control plugin|No Content|
|**502**|Failed to submit payment transaction|No Content|
|**503**|Payment in unknown status, failed to receive gateway response|No Content|
|**504**|Payment operation timeout|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getpaymentbyexternalkey"></a>
## Retrieve a payment by external key

```
GET /rest/v1/payments

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/payments?withPluginInfo=false&withAttempts=false&externalKey=c2f4966d-c944-4086-a7b7-4759b5d31913&audit=NONE'


Reponse Example

{
  "accountId": "9c3f0bea-d1e1-40ae-98bf-81d317885288",
  "paymentId": "c2f4966d-c944-4086-a7b7-4759b5d31913",
  "paymentNumber": "350",
  "paymentExternalKey": "c2f4966d-c944-4086-a7b7-4759b5d31913",
  "authAmount": 20,
  "capturedAmount": 20,
  "purchasedAmount": 0,
  "refundedAmount": 0,
  "creditedAmount": 0,
  "currency": "USD",
  "paymentMethodId": "569830ae-d246-4daa-8671-ea5f5e6431ea",
  "transactions": [
    {
      "transactionId": "fbd1ac86-17cb-45bd-a196-d1ba8fb8ce52",
      "transactionExternalKey": "fbd1ac86-17cb-45bd-a196-d1ba8fb8ce52",
      "paymentId": "c2f4966d-c944-4086-a7b7-4759b5d31913",
      "paymentExternalKey": "c2f4966d-c944-4086-a7b7-4759b5d31913",
      "transactionType": "AUTHORIZE",
      "amount": 20,
      "currency": "USD",
      "effectiveDate": "2017-03-25T15:30:00.000Z",
      "processedAmount": 20,
      "processedCurrency": "USD",
      "status": "SUCCESS",
      "gatewayErrorCode": null,
      "gatewayErrorMsg": null,
      "firstPaymentReferenceId": null,
      "secondPaymentReferenceId": null,
      "properties": null,
      "auditLogs": []
    },
    {
      "transactionId": "85c9dd56-34f7-4dba-ab26-001121982629",
      "transactionExternalKey": "85c9dd56-34f7-4dba-ab26-001121982629",
      "paymentId": "c2f4966d-c944-4086-a7b7-4759b5d31913",
      "paymentExternalKey": "c2f4966d-c944-4086-a7b7-4759b5d31913",
      "transactionType": "CAPTURE",
      "amount": 20,
      "currency": "USD",
      "effectiveDate": "2017-03-25T15:31:32.000Z",
      "processedAmount": 20,
      "processedCurrency": "USD",
      "status": "SUCCESS",
      "gatewayErrorCode": null,
      "gatewayErrorMsg": null,
      "firstPaymentReferenceId": null,
      "secondPaymentReferenceId": null,
      "properties": null,
      "auditLogs": []
    }
  ],
  "paymentAttempts": null,
  "auditLogs": []
}
```

GET /rest/v1/payments


### Description
external key 로 결제 이력을 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**externalKey**  <br>*optional*|string||
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**withAttempts**  <br>*optional*|boolean|`"false"`|
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[PaymentJson](#paymentjson)|
|**404**|Payment not found|No Content|


### Produces

* `application/json`


<a name="completetransactionbyexternalkey"></a>
## Complete an existing transaction

```
POST /rest/v1/accounts/{accountId}/emails

Request Example

curl -X PUT 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "transactionId": "85c9dd56-34f7-4dba-ab26-001121982629",
  "paymentExternalKey": "c2f4966d-c944-4086-a7b7-4759b5d31913"
}' 
'http://localhost:18080/rest/v1/payments'


Reponse Example

201 Created
```

PUT /rest/v1/payments


### Description
paymentExternalKey 사용. 결제 트랜잭션을 Complete 상태로 전환한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|Payment transaction created successfully|No Content|
|**402**|Transaction declined by gateway|No Content|
|**404**|Account or payment not found|No Content|
|**422**|Payment is aborted by a control plugin|No Content|
|**502**|Failed to submit payment transaction|No Content|
|**503**|Payment in unknown status, failed to receive gateway response|No Content|
|**504**|Payment operation timeout|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="voidpaymentbyexternalkey"></a>
## Void an existing payment

```
DELETE /rest/v1/payments

Request Example

curl -X DELETE 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "paymentExternalKey": "a488ddaa-efe9-4837-85f6-03ad1d127fb6"
}' 
'http://localhost:18080/rest/v1/payments'


Reponse Example

201 Void(Deleted)
```

DELETE /rest/v1/payments


### Description
paymentExternalKey 사용. PG 사를 통해 Authorization (결제 승인 대기) 중인 결제 이력에 대해 결제 취소를 한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|Payment transaction created successfully|No Content|
|**402**|Transaction declined by gateway|No Content|
|**404**|Account or payment not found|No Content|
|**422**|Payment is aborted by a control plugin|No Content|
|**502**|Failed to submit payment transaction|No Content|
|**503**|Payment in unknown status, failed to receive gateway response|No Content|
|**504**|Payment operation timeout|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="cancelscheduledpaymenttransactionbyexternalkey"></a>
## Cancels a scheduled payment attempt retry

```
DELETE /rest/v1/payments/cancelScheduledPaymentTransaction

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/payments/cancelScheduledPaymentTransaction?transactionExternalKey=fbd1ac86-17cb-45bd-a196-d1ba8fb8ce52'



Reponse Example

200 DELETED
```

DELETE /rest/v1/payments/cancelScheduledPaymentTransaction


### Description
transactionExternalKey 사용. 결제 재시도 예약중인 결제 트랜잭션을 예약취소 시킨다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Query**|**transactionExternalKey**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid paymentTransactionExternalKey supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="chargebackreversalpaymentbyexternalkey"></a>
## Record a chargeback reversal

```
POST /rest/v1/payments/chargebackReversals

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "paymentExternalKey": "762dfb3f-cce1-4b7b-b1ff-6bb493025768",
  "transactionExternalKey":"db25927b-fd17-40bf-81bc-1955e9520bc2"
}' 
'http://localhost:18080/rest/v1/payments/chargebackReversals'


Reponse Example

201 Created
```

POST /rest/v1/payments/chargebackReversals


### Description
paymentExternalKey 사용. 결제이력의 chargeback(지불 거절) 요청을 취소한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|Payment transaction created successfully|No Content|
|**402**|Transaction declined by gateway|No Content|
|**404**|Account or payment not found|No Content|
|**422**|Payment is aborted by a control plugin|No Content|
|**502**|Failed to submit payment transaction|No Content|
|**503**|Payment in unknown status, failed to receive gateway response|No Content|
|**504**|Payment operation timeout|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="chargebackpaymentbyexternalkey"></a>
## Record a chargeback

```
POST /rest/v1/payments/chargebacks

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "paymentExternalKey": "15250bfe-6dc4-46fa-9ae1-81f6feb45264",
  "amount": 20,
  "currency": "USD"
}' 
'http://localhost:18080/rest/v1/payments/chargebacks'


Reponse Example

201 Created
```

POST /rest/v1/payments/chargebacks


### Description
paymentExternalKey 사용. 결제이력에 대해 chargeback(지불 거절) 요청을 한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|Payment transaction created successfully|No Content|
|**402**|Transaction declined by gateway|No Content|
|**404**|Account or payment not found|No Content|
|**422**|Payment is aborted by a control plugin|No Content|
|**502**|Failed to submit payment transaction|No Content|
|**503**|Payment in unknown status, failed to receive gateway response|No Content|
|**504**|Payment operation timeout|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="createcombopayment"></a>
## Combo api to create a new payment transaction on a existing (or not) account 

```
POST /rest/v1/payments/combo

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "account": {
    "name": "combo-account",
    "email": "sppark@uengine.org",
    "billCycleDayLocal": 0,
    "currency": "USD",
    "timeZone": "UTC",
    "address1": "",
    "postalCode": "",
    "company": "unionnec",
    "city": "",
    "state": "",
    "country": "KR",
    "locale": "ko_KR",
    "phone": "100000000",
    "notes": "",
    "isNotifiedForInvoices": true
  },
  "paymentMethod": {
    "isDefault": true,
    "pluginName": "__EXTERNAL_PAYMENT__"
  },
  "transaction": {
    "transactionType": "PURCHASE",
    "amount": 10,
    "currency": "USD"
  }
}' 
'http://localhost:18080/rest/v1/payments/combo'


Reponse Example

201 Created
```

POST /rest/v1/payments/combo


### Description
구매자 생성과 결제 수단 등록, 결제 트랜잭션 생성을 한번에 진행할 수 있도록 한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[ComboPaymentTransactionJson](#combopaymenttransactionjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|Payment transaction created successfully|No Content|
|**400**|Invalid data for Account or PaymentMethod|No Content|
|**402**|Transaction declined by gateway|No Content|
|**422**|Payment is aborted by a control plugin|No Content|
|**502**|Failed to submit payment transaction|No Content|
|**503**|Payment in unknown status, failed to receive gateway response|No Content|
|**504**|Payment operation timeout|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getpayments"></a>
## Get payments

```
GET /rest/v1/payments/pagination

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/payments/pagination?offset=0&limit=1&audit=NONE&withPluginInfo=false&withAttempts=false'



Reponse Example

[
  {
    "accountId": "8c3d99ff-1659-4153-917e-f4f27172f92d",
    "paymentId": "95100c5c-26ba-492c-85fe-234c028e6588",
    "paymentNumber": "328",
    "paymentExternalKey": "b8a184a2-a3b6-45a3-be82-55c9d8fe5a0b",
    "authAmount": 0,
    "capturedAmount": 0,
    "purchasedAmount": 10,
    "refundedAmount": 0,
    "creditedAmount": 0,
    "currency": "USD",
    "paymentMethodId": "49a563b1-4b8b-4a3b-b214-a09c4c19a0d2",
    "transactions": [
      {
        "transactionId": "d811ea38-c4b8-4305-99ed-7faaec04c40b",
        "transactionExternalKey": "459f2b41-5e42-4534-a4c5-78f892b9ff73",
        "paymentId": "95100c5c-26ba-492c-85fe-234c028e6588",
        "paymentExternalKey": "b8a184a2-a3b6-45a3-be82-55c9d8fe5a0b",
        "transactionType": "PURCHASE",
        "amount": 10,
        "currency": "USD",
        "effectiveDate": "2017-03-22T00:02:26.000Z",
        "processedAmount": 10,
        "processedCurrency": "USD",
        "status": "SUCCESS",
        "gatewayErrorCode": null,
        "gatewayErrorMsg": null,
        "firstPaymentReferenceId": null,
        "secondPaymentReferenceId": null,
        "properties": null,
        "auditLogs": []
      }
    ],
    "paymentAttempts": null,
    "auditLogs": []
  }
]
```

GET /rest/v1/payments/pagination


### Description
결제 이력을 페이징 하여 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|
|**Query**|**pluginName**  <br>*optional*|string||
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**withAttempts**  <br>*optional*|boolean|`"false"`|
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [PaymentJson](#paymentjson) > array|


### Produces

* `application/json`


<a name="refundpaymentbyexternalkey"></a>
## Refund an existing payment

```
POST /rest/v1/payments/refunds

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "paymentExternalKey": "762dfb3f-cce1-4b7b-b1ff-6bb493025768",
  "amount": 10,
  "currency": "USD"
}' 
'http://localhost:18080/rest/v1/payments/refunds'


Reponse Example

201 Created
```

POST /rest/v1/payments/refunds


### Description
paymentExternalKey 사용. 결제 이력에 대해 환불 처리한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|Payment transaction created successfully|No Content|
|**402**|Transaction declined by gateway|No Content|
|**404**|Account or payment not found|No Content|
|**422**|Payment is aborted by a control plugin|No Content|
|**502**|Failed to submit payment transaction|No Content|
|**503**|Payment in unknown status, failed to receive gateway response|No Content|
|**504**|Payment operation timeout|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="searchpayments"></a>
## Search payments

```
GET /rest/v1/payments/search/{searchKey}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/payments/search/e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8?offset=0&limit=100&audit=NONE&withPluginInfo=false&withAttempts=false'


Reponse Example

[
  {
    "accountId": "8c3d99ff-1659-4153-917e-f4f27172f92d",
    "paymentId": "95100c5c-26ba-492c-85fe-234c028e6588",
    "paymentNumber": "328",
    "paymentExternalKey": "b8a184a2-a3b6-45a3-be82-55c9d8fe5a0b",
    "authAmount": 0,
    "capturedAmount": 0,
    "purchasedAmount": 10,
    "refundedAmount": 0,
    "creditedAmount": 0,
    "currency": "USD",
    "paymentMethodId": "49a563b1-4b8b-4a3b-b214-a09c4c19a0d2",
    "transactions": [
      {
        "transactionId": "d811ea38-c4b8-4305-99ed-7faaec04c40b",
        "transactionExternalKey": "459f2b41-5e42-4534-a4c5-78f892b9ff73",
        "paymentId": "95100c5c-26ba-492c-85fe-234c028e6588",
        "paymentExternalKey": "b8a184a2-a3b6-45a3-be82-55c9d8fe5a0b",
        "transactionType": "PURCHASE",
        "amount": 10,
        "currency": "USD",
        "effectiveDate": "2017-03-22T00:02:26.000Z",
        "processedAmount": 10,
        "processedCurrency": "USD",
        "status": "SUCCESS",
        "gatewayErrorCode": null,
        "gatewayErrorMsg": null,
        "firstPaymentReferenceId": null,
        "secondPaymentReferenceId": null,
        "properties": null,
        "auditLogs": []
      }
    ],
    "paymentAttempts": null,
    "auditLogs": []
  }
]
```

GET /rest/v1/payments/search/{searchKey}


### Description
주어진 검색어로 결제 이력을 페이징 하여 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**searchKey**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|
|**Query**|**pluginName**  <br>*optional*|string||
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**withAttempts**  <br>*optional*|boolean|`"false"`|
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [PaymentJson](#paymentjson) > array|


### Produces

* `application/json`


<a name="captureauthorization"></a>
## Capture an existing authorization

```
POST /rest/v1/payments/{paymentId}

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "amount": 20,
  "currency": "USD"
}' 
'http://localhost:18080/rest/v1/payments/85c92ff4-48ef-4ab6-9100-933f4853c6c0'


Reponse Example

201 Created
```

POST /rest/v1/payments/{paymentId}


### Description
PG 사를 통해 Authorization (결제 승인 대기) 중인 결제 이력에 대해, 결제 확인을 한다. 이후 PG 사에서 판매자(조직) 의 구좌에 입금처리가 완료된다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|Payment transaction created successfully|No Content|
|**400**|Invalid paymentId supplied|No Content|
|**402**|Transaction declined by gateway|No Content|
|**404**|Account or payment not found|No Content|
|**422**|Payment is aborted by a control plugin|No Content|
|**502**|Failed to submit payment transaction|No Content|
|**503**|Payment in unknown status, failed to receive gateway response|No Content|
|**504**|Payment operation timeout|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getpayment"></a>
## Retrieve a payment by id

```
GET /rest/v1/payments/{paymentId}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/payments/762dfb3f-cce1-4b7b-b1ff-6bb493025768?withPluginInfo=false&withAttempts=false&audit=NONE'


Reponse Example

{
  "accountId": "e6a43c25-bc9b-40c2-a2e4-a86dfb0e6bd8",
  "paymentId": "762dfb3f-cce1-4b7b-b1ff-6bb493025768",
  "paymentNumber": "352",
  "paymentExternalKey": "762dfb3f-cce1-4b7b-b1ff-6bb493025768",
  "authAmount": 0,
  "capturedAmount": 0,
  "purchasedAmount": 10,
  "refundedAmount": 10,
  "creditedAmount": 0,
  "currency": "USD",
  "paymentMethodId": "32cdf8e8-cef1-4995-afcb-ac16eefe7672",
  "transactions": [
    {
      "transactionId": "499c43bb-25a9-428e-bc5c-c8a90d202f79",
      "transactionExternalKey": "499c43bb-25a9-428e-bc5c-c8a90d202f79",
      "paymentId": "762dfb3f-cce1-4b7b-b1ff-6bb493025768",
      "paymentExternalKey": "762dfb3f-cce1-4b7b-b1ff-6bb493025768",
      "transactionType": "PURCHASE",
      "amount": 20,
      "currency": "USD",
      "effectiveDate": "2017-03-25T16:35:11.000Z",
      "processedAmount": 20,
      "processedCurrency": "USD",
      "status": "SUCCESS",
      "gatewayErrorCode": null,
      "gatewayErrorMsg": "Success",
      "firstPaymentReferenceId": null,
      "secondPaymentReferenceId": null,
      "properties": null,
      "auditLogs": []
    },
    {
      "transactionId": "db25927b-fd17-40bf-81bc-1955e9520bc2",
      "transactionExternalKey": "db25927b-fd17-40bf-81bc-1955e9520bc2",
      "paymentId": "762dfb3f-cce1-4b7b-b1ff-6bb493025768",
      "paymentExternalKey": "762dfb3f-cce1-4b7b-b1ff-6bb493025768",
      "transactionType": "CHARGEBACK",
      "amount": 20,
      "currency": "USD",
      "effectiveDate": "2017-03-25T16:36:28.000Z",
      "processedAmount": 20,
      "processedCurrency": "USD",
      "status": "SUCCESS",
      "gatewayErrorCode": null,
      "gatewayErrorMsg": null,
      "firstPaymentReferenceId": null,
      "secondPaymentReferenceId": null,
      "properties": null,
      "auditLogs": []
    },
    {
      "transactionId": "4b8bd986-8d1f-4167-b532-6d9a0d125c48",
      "transactionExternalKey": "db25927b-fd17-40bf-81bc-1955e9520bc2",
      "paymentId": "762dfb3f-cce1-4b7b-b1ff-6bb493025768",
      "paymentExternalKey": "762dfb3f-cce1-4b7b-b1ff-6bb493025768",
      "transactionType": "CHARGEBACK",
      "amount": null,
      "currency": null,
      "effectiveDate": "2017-03-25T16:37:02.000Z",
      "processedAmount": 0,
      "processedCurrency": null,
      "status": "PAYMENT_FAILURE",
      "gatewayErrorCode": null,
      "gatewayErrorMsg": null,
      "firstPaymentReferenceId": null,
      "secondPaymentReferenceId": null,
      "properties": null,
      "auditLogs": []
    },
    {
      "transactionId": "b97032d7-ded7-4f2b-be93-08f2e2709fdc",
      "transactionExternalKey": "b97032d7-ded7-4f2b-be93-08f2e2709fdc",
      "paymentId": "762dfb3f-cce1-4b7b-b1ff-6bb493025768",
      "paymentExternalKey": "762dfb3f-cce1-4b7b-b1ff-6bb493025768",
      "transactionType": "REFUND",
      "amount": 10,
      "currency": "USD",
      "effectiveDate": "2017-03-25T16:37:38.000Z",
      "processedAmount": 10,
      "processedCurrency": "USD",
      "status": "SUCCESS",
      "gatewayErrorCode": null,
      "gatewayErrorMsg": "Success",
      "firstPaymentReferenceId": null,
      "secondPaymentReferenceId": null,
      "properties": null,
      "auditLogs": []
    },
    {
      "transactionId": "a2b88cef-1848-46bc-9efb-4be1c119cea4",
      "transactionExternalKey": "a2b88cef-1848-46bc-9efb-4be1c119cea4",
      "paymentId": "762dfb3f-cce1-4b7b-b1ff-6bb493025768",
      "paymentExternalKey": "762dfb3f-cce1-4b7b-b1ff-6bb493025768",
      "transactionType": "CHARGEBACK",
      "amount": 10,
      "currency": "USD",
      "effectiveDate": "2017-03-25T16:38:27.000Z",
      "processedAmount": 10,
      "processedCurrency": "USD",
      "status": "SUCCESS",
      "gatewayErrorCode": null,
      "gatewayErrorMsg": null,
      "firstPaymentReferenceId": null,
      "secondPaymentReferenceId": null,
      "properties": null,
      "auditLogs": []
    }
  ],
  "paymentAttempts": null,
  "auditLogs": []
}
```

GET /rest/v1/payments/{paymentId}


### Description
아이디로 결제 이력을 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**paymentId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**withAttempts**  <br>*optional*|boolean|`"false"`|
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[PaymentJson](#paymentjson)|
|**400**|Invalid paymentId supplied|No Content|
|**404**|Payment not found|No Content|


### Produces

* `application/json`


<a name="completetransaction"></a>
## Complete an existing transaction

```
PUT /rest/v1/payments/{paymentId}

Request Example

curl -X PUT 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
"transactionId": "0c6d78d4-b232-4816-a4fc-57abf9be1baa"
}' 
'http://localhost:18080/rest/v1/payments/85c92ff4-48ef-4ab6-9100-933f4853c6c0'


Reponse Example

201 Created
```

PUT /rest/v1/payments/{paymentId}


### Description
결제 트랜잭션을 Complete 처리 한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|Payment transaction created successfully|No Content|
|**400**|Invalid paymentId supplied|No Content|
|**402**|Transaction declined by gateway|No Content|
|**404**|Account or payment not found|No Content|
|**422**|Payment is aborted by a control plugin|No Content|
|**502**|Failed to submit payment transaction|No Content|
|**503**|Payment in unknown status, failed to receive gateway response|No Content|
|**504**|Payment operation timeout|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="voidpayment"></a>
## Void an existing payment

```
DELETE /rest/v1/payments/{paymentId}

Request Example

curl -X DELETE 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "paymentId": "d042687b-27a6-48bf-99ac-ca741eea3c16"
}' 
'http://localhost:18080/rest/v1/payments/d042687b-27a6-48bf-99ac-ca741eea3c16'


Reponse Example

201 Void(Deleted)
```

DELETE /rest/v1/payments/{paymentId}


### Description
PG 사를 통해 Authorization (결제 승인 대기) 중인 결제 이력에 대해, 결제 취소를 한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|Payment transaction created successfully|No Content|
|**400**|Invalid paymentId supplied|No Content|
|**402**|Transaction declined by gateway|No Content|
|**404**|Account or payment not found|No Content|
|**422**|Payment is aborted by a control plugin|No Content|
|**502**|Failed to submit payment transaction|No Content|
|**503**|Payment in unknown status, failed to receive gateway response|No Content|
|**504**|Payment operation timeout|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="chargebackreversalpayment"></a>
## Record a chargeback reversal

```
POST /rest/v1/payments/{paymentId}/chargebackReversals

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
"transactionExternalKey": "a2b88cef-1848-46bc-9efb-4be1c119cea4"
}' 
'http://localhost:18080/rest/v1/payments/762dfb3f-cce1-4b7b-b1ff-6bb493025768/chargebackReversals'


Reponse Example

201 Created
```

POST /rest/v1/payments/{paymentId}/chargebackReversals


### Description
결제이력의 chargeback(지불 거절) 요청을 취소한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|Payment transaction created successfully|No Content|
|**400**|Invalid paymentId supplied|No Content|
|**402**|Transaction declined by gateway|No Content|
|**404**|Account or payment not found|No Content|
|**422**|Payment is aborted by a control plugin|No Content|
|**502**|Failed to submit payment transaction|No Content|
|**503**|Payment in unknown status, failed to receive gateway response|No Content|
|**504**|Payment operation timeout|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="chargebackpayment"></a>
## Record a chargeback

```
POST /rest/v1/payments/{paymentId}/chargebacks

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "amount": 20,
  "currency": "USD"
}' 
'http://localhost:18080/rest/v1/payments/685bf6be-17ad-48a3-ae87-a578d0ab1c04/chargebacks'


Reponse Example

201 Created
```

POST /rest/v1/payments/{paymentId}/chargebacks


### Description
결제이력에 chargeback(지불 거절) 요청을 한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|Payment transaction created successfully|No Content|
|**400**|Invalid paymentId supplied|No Content|
|**402**|Transaction declined by gateway|No Content|
|**404**|Account or payment not found|No Content|
|**422**|Payment is aborted by a control plugin|No Content|
|**502**|Failed to submit payment transaction|No Content|
|**503**|Payment in unknown status, failed to receive gateway response|No Content|
|**504**|Payment operation timeout|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="createpaymentcustomfields"></a>
## Add custom fields to payment

```
POST /rest/v1/payments/{paymentId}/customFields

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '[
  {
    "name": "key1",
    "value": "value1"
  }
]' 
'http://localhost:18080/rest/v1/payments/685bf6be-17ad-48a3-ae87-a578d0ab1c04/customFields'


Reponse Example

201 Created
```

POST /rest/v1/payments/{paymentId}/customFields


### Description
결제 이력에 커스텀 필드를 추가한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|< [CustomFieldJson](#customfieldjson) > array|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getpaymentcustomfields"></a>
## Retrieve payment custom fields

```
GET /rest/v1/payments/{paymentId}/customFields

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/payments/685bf6be-17ad-48a3-ae87-a578d0ab1c04/customFields?audit=NONE'


Reponse Example

[
  {
    "customFieldId": "81b021a5-0bf3-4b09-b83e-f315fa054382",
    "objectId": "685bf6be-17ad-48a3-ae87-a578d0ab1c04",
    "objectType": "PAYMENT",
    "name": "key1",
    "value": "value1",
    "auditLogs": []
  }
]
```

GET /rest/v1/payments/{paymentId}/customFields


### Description
결제 이력의 커스텀 필드를 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**paymentId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [CustomFieldJson](#customfieldjson) > array|
|**400**|Invalid payment id supplied|No Content|


### Produces

* `application/json`


<a name="deletepaymentcustomfields"></a>
## Remove custom fields from payment

```
DELETE /rest/v1/payments/{paymentId}/customFields

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/payments/685bf6be-17ad-48a3-ae87-a578d0ab1c04/customFields?customFieldList=81b021a5-0bf3-4b09-b83e-f315fa054382'


Reponse Example

200 Deleted
```

DELETE /rest/v1/payments/{paymentId}/customFields


### Description
결제 이력의 커스텀 필드를 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**customFieldList**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="refundpayment"></a>
## Refund an existing payment

```
POST /rest/v1/payments/{paymentId}/refunds

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "amount": 20,
  "currency": "USD"
}' 
'http://localhost:18080/rest/v1/payments/32cd33b9-e763-4c30-a923-64276afbb839/refunds'


Reponse Example

201 Created
```

POST /rest/v1/payments/{paymentId}/refunds


### Description
결제이력에 대해 환불처리를 한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|Payment transaction created successfully|No Content|
|**400**|Invalid paymentId supplied|No Content|
|**402**|Transaction declined by gateway|No Content|
|**404**|Account or payment not found|No Content|
|**422**|Payment is aborted by a control plugin|No Content|
|**502**|Failed to submit payment transaction|No Content|
|**503**|Payment in unknown status, failed to receive gateway response|No Content|
|**504**|Payment operation timeout|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="createpaymenttags"></a>
## Add tags to payment

```
POST /rest/v1/payments/{paymentId}/tags

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/payments/85c92ff4-48ef-4ab6-9100-933f4853c6c0/tags?tagList=00000000-0000-0000-0000-000000000001'


Reponse Example

201 Created
```

POST /rest/v1/payments/{paymentId}/tags


### Description
결제 이력에 태그를 추가한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getpaymenttags"></a>
## Retrieve payment payment tags

```
GET /rest/v1/payments/{paymentId}/tags

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/payments/85c92ff4-48ef-4ab6-9100-933f4853c6c0/tags?audit=NONE&includedDeleted=false'


Reponse Example

[
  {
    "tagId": "5725c38c-7305-49d8-8bdd-b000b3c0736b",
    "objectType": "PAYMENT",
    "objectId": "85c92ff4-48ef-4ab6-9100-933f4853c6c0",
    "tagDefinitionId": "00000000-0000-0000-0000-000000000001",
    "tagDefinitionName": "AUTO_PAY_OFF",
    "auditLogs": []
  }
]
```

GET /rest/v1/payments/{paymentId}/tags


### Description
결제 이력의 태그를 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**paymentId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**includedDeleted**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [TagJson](#tagjson) > array|
|**400**|Invalid payment id supplied|No Content|
|**404**|Invoice not found|No Content|


### Produces

* `application/json`


<a name="deletepaymenttags"></a>
## Remove tags from payment

```
DELETE /rest/v1/payments/{paymentId}/tags

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/payments/85c92ff4-48ef-4ab6-9100-933f4853c6c0/tags?tagList=00000000-0000-0000-0000-000000000001'


Reponse Example

200 Deleted
```

DELETE /rest/v1/payments/{paymentId}/tags


### Description
결제 이력의 태그를 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="cancelscheduledpaymenttransactionbyid"></a>
## Cancels a scheduled payment attempt retry

```
DELETE /rest/v1/payments/{paymentTransactionId}/cancelScheduledPaymentTransaction

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/payments/0c6d78d4-b232-4816-a4fc-57abf9be1baa/cancelScheduledPaymentTransaction'


Reponse Example

200 Deleted
```

DELETE /rest/v1/payments/{paymentTransactionId}/cancelScheduledPaymentTransaction


### Description
결제 재시도 예약중인 결제 트랜잭션을 예약취소 시킨다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentTransactionId**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid paymentTransactionId supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="product_resource"></a>
# Product

<a name="createproduct"></a>
## Create product

```
POST /rest/v1/product

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "name": "Sample Product",
  "category": "BASE"
}' 
'http://localhost:18080/rest/v1/product'


Reponse Example

201 Created
```

POST /rest/v1/product


### Description
Product 을 생성한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Body**|**body**  <br>*required*|[ProductJson](#productjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|successful operation|No Content|
|**400**|Invalid Request|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="listproducts"></a>
## List products

```
GET /rest/v1/product/pagination

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/product/pagination?offset=0&limit=100'


Reponse Example

[
  {
    "record_id": 17,
    "id": "PRD_0000000017",
    "name": "FORCS-BASIC",
    "category": "BASE",
    "owner_account_id": null,
    "description": "",
    "redirect_url": "",
    "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
    "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
    "is_active": "Y",
    "plan_seq": 2,
    "usage_seq": 1,
    "reg_dt": "2017-03-08"
  }
]
```

GET /rest/v1/product/pagination


### Description
product 를 페이징 하여 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**category**  <br>*optional*|enum (BASE, ADD_ON)||
|**Query**|**is_active**  <br>*optional*|enum (Y, N)||
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [ProductJson](#productjson) > array|
|**204**|No Content|No Content|
|**400**|Invalid Request|No Content|


### Produces

* `application/json`


<a name="searchproduct"></a>
## Search products

```
GET /rest/v1/product/search/{searchKey}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/product/search/FORCS?offset=0&limit=100'


Reponse Example

[
  {
    "record_id": 17,
    "id": "PRD_0000000017",
    "name": "FORCS-BASIC",
    "category": "BASE",
    "owner_account_id": null,
    "description": "",
    "redirect_url": "",
    "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
    "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
    "is_active": "Y",
    "plan_seq": 2,
    "usage_seq": 1,
    "reg_dt": "2017-03-08"
  }
]
```

GET /rest/v1/product/search/{searchKey}


### Description
주어진 검색어에 해당하는 product 들을 페이징 처리하여 반환한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**searchKey**  <br>*required*|string||
|**Query**|**category**  <br>*optional*|enum (BASE, ADD_ON)||
|**Query**|**is_active**  <br>*optional*|enum (Y, N)||
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [ProductJson](#productjson) > array|
|**204**|No Content|No Content|
|**400**|Invalid Request|No Content|


### Produces

* `application/json`


<a name="getproduct"></a>
## Retrieve an product by id

```
GET /rest/v1/product/{productId}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/product/PRD_0000000017'


Reponse Example

{
  "record_id": 17,
  "id": "PRD_0000000017",
  "name": "FORCS-BASIC",
  "category": "BASE",
  "owner_account_id": null,
  "description": "",
  "redirect_url": "",
  "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
  "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
  "is_active": "Y",
  "plan_seq": 2,
  "usage_seq": 1,
  "reg_dt": "2017-03-08"
}
```

GET /rest/v1/product/{productId}


### Description
product 을 아이디로 조회한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**productId**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[ProductJson](#productjson)|
|**400**|Invalid product id supplied|No Content|
|**404**|product not found|No Content|


### Produces

* `application/json`


<a name="updateproduct"></a>
## Update product

```
PUT /rest/v1/product/{productId}

Request Example

curl -X PUT 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "name": "FORCS-BASIC",
  "category": "BASE",
  "description": "Add description",
  "is_active": "Y"
}' 
'http://localhost:18080/rest/v1/product/PRD_0000000017'


Reponse Example

200

{
  "record_id": 17,
  "id": "PRD_0000000017",
  "name": "FORCS-BASIC",
  "category": "BASE",
  "owner_account_id": null,
  "description": "Add description",
  "redirect_url": null,
  "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
  "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
  "is_active": "Y",
  "plan_seq": 2,
  "usage_seq": 1,
  "reg_dt": "2017-03-08"
}
```

PUT /rest/v1/product/{productId}


### Description
product 정보를 업데이트한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**productId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|[ProductJson](#productjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[ProductJson](#productjson)|
|**400**|Invalid product data supplied|No Content|
|**404**|product not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="deleteproduct"></a>
## Remove product

```
DELETE /rest/v1/product/{productId}

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/product/PRD_0000000019'


Reponse Example

204 No content
```

DELETE /rest/v1/product/{productId}


### Description
product 을 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**productId**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|successful operation|No Content|
|**400**|Invalid product id supplied|No Content|
|**404**|product not found|No Content|


### Produces

* `application/json`


<a name="updateproductactive"></a>
## Set product active

```
PUT /rest/v1/product/{productId}/active

Request Example

curl -X PUT 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "is_active": "N"
}' 
'http://localhost:18080/rest/v1/product/PRD_0000000017/active'


Reponse Example

200

{
  "record_id": 17,
  "id": "PRD_0000000017",
  "name": "FORCS-BASIC",
  "category": "BASE",
  "owner_account_id": null,
  "description": "Add description",
  "redirect_url": null,
  "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
  "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
  "is_active": "N",
  "plan_seq": 2,
  "usage_seq": 1,
  "reg_dt": "2017-03-08"
}
```

PUT /rest/v1/product/{productId}/active


### Description
product 의 active 여부를 결정한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**productId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|[ProductJson](#productjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[ProductJson](#productjson)|
|**400**|Invalid product data supplied|No Content|
|**404**|product not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="createproductversion"></a>
## Create product version

```
POST /rest/v1/product/{productId}/version

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "effective_date": "2017-03-20",
  "plans": [
    {
      "display_name": "basic",
      "is_active": "Y",
      "initialPhases": [
        {
          "type": "TRIAL",
          "duration": {
            "unit": "DAYS",
            "number": 30
          },
          "recurring": null,
          "fixed": {
            "fixedPrice": [
              {
                "currency": "USD",
                "value": 0
              }
            ]
          },
          "usages": null
        },
        {
          "type": "DISCOUNT",
          "duration": {
            "unit": "MONTHS",
            "number": 2
          },
          "recurring": {
            "billingPeriod": "MONTHLY",
            "recurringPrice": [
              {
                "currency": "USD",
                "value": 8
              }
            ]
          },
          "fixed": null,
          "usages": null
        }
      ],
      "finalPhase": {
        "type": "EVERGREEN",
        "duration": {
          "unit": "UNLIMITED",
          "number": null
        },
        "recurring": {
          "billingPeriod": "MONTHLY",
          "recurringPrice": [
            {
              "currency": "USD",
              "value": 10
            }
          ]
        },
        "fixed": null,
        "usages": [
          {
            "display_name": "storage-usage",
            "billingMode": "IN_ARREAR",
            "usageType": "CONSUMABLE",
            "billingPeriod": "MONTHLY",
            "tiers": [
              {
                "unit": "storage",
                "size": 10,
                "prices": [
                  {
                    "currency": "USD",
                    "value": 3
                  }
                ],
                "max": 100
              },
              {
                "unit": "storage",
                "size": 10,
                "prices": [
                  {
                    "currency": "USD",
                    "value": 2
                  }
                ],
                "max": 500
              }
            ]
          }
        ]
      }
    }
  ]
}' 
'http://localhost:18080/rest/v1/product/PRD_0000000020/version'


Reponse Example

201 Created
```

POST /rest/v1/product/{productId}/version


### Description
Product Version 을 생성한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**productId**  <br>*required*|string|
|**Body**|**body**  <br>*required*|[ProductVersionJson](#productversionjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|successful operation|No Content|
|**400**|Invalid Request|No Content|
|**404**|product not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="listproductversions"></a>
## List Product Version

```
GET /rest/v1/product/{productId}/version

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/product/PRD_0000000020/version'


Reponse Example

[
  {
    "id": 23,
    "product_id": "PRD_0000000020",
    "version": 1,
    "effective_date": "2017-03-20",
    "is_current": "Y",
    "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
    "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
    "reg_dt": "2017-03-26"
  }
]
```

GET /rest/v1/product/{productId}/version


### Description
product 의 모든 version 을 조회한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**productId**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [ProductVersionJson](#productversionjson) > array|
|**400**|Invalid product id supplied|No Content|
|**404**|product not found|No Content|


### Produces

* `application/json`


<a name="getcurrentproductversion"></a>
## Retrieve an current product version

```
GET /rest/v1/product/{productId}/version/current

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/product/PRD_0000000020/version/current'


Reponse Example

{
  "id": 23,
  "product_id": "PRD_0000000020",
  "version": 1,
  "effective_date": "2017-03-20",
  "is_current": "Y",
  "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
  "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
  "plans": [
    {
      "name": "PRD_0000000020_PL_000001",
      "display_name": "basic",
      "is_active": "Y",
      "initialPhases": [
        {
          "type": "TRIAL",
          "duration": {
            "unit": "DAYS",
            "number": 30
          },
          "recurring": null,
          "fixed": {
            "fixedPrice": [
              {
                "currency": "USD",
                "value": 0
              }
            ]
          },
          "usages": null
        },
        {
          "type": "DISCOUNT",
          "duration": {
            "unit": "MONTHS",
            "number": 2
          },
          "recurring": {
            "billingPeriod": "MONTHLY",
            "recurringPrice": [
              {
                "currency": "USD",
                "value": 8
              }
            ]
          },
          "fixed": null,
          "usages": null
        }
      ],
      "finalPhase": {
        "type": "EVERGREEN",
        "duration": {
          "unit": "UNLIMITED",
          "number": null
        },
        "recurring": {
          "billingPeriod": "MONTHLY",
          "recurringPrice": [
            {
              "currency": "USD",
              "value": 10
            }
          ]
        },
        "fixed": null,
        "usages": [
          {
            "name": "PRD_0000000020_USG_000001",
            "display_name": "storage-usage",
            "billingMode": "IN_ARREAR",
            "usageType": "CONSUMABLE",
            "billingPeriod": "MONTHLY",
            "tiers": [
              {
                "unit": "storage",
                "size": 10,
                "prices": [
                  {
                    "currency": "USD",
                    "value": 3
                  }
                ],
                "max": 100
              },
              {
                "unit": "storage",
                "size": 10,
                "prices": [
                  {
                    "currency": "USD",
                    "value": 2
                  }
                ],
                "max": 500
              }
            ]
          }
        ]
      },
      "number_of_subscriptions_referenced_by_version": 0,
      "number_of_subscriptions": 0
    }
  ],
  "reg_dt": "2017-03-26"
}
```

GET /rest/v1/product/{productId}/version/current


### Description
product 의 현재 시각 적용 version 을 조회한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**productId**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[ProductVersionJson](#productversionjson)|
|**400**|Invalid product version supplied|No Content|
|**404**|product version not found|No Content|


### Produces

* `application/json`


<a name="getproductversion"></a>
## Retrieve an product version by version

```
GET /rest/v1/product/{productId}/version/{version}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/product/PRD_0000000020/version/1'


Reponse Example

{
  "id": 23,
  "product_id": "PRD_0000000020",
  "version": 1,
  "effective_date": "2017-03-20",
  "is_current": "Y",
  "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
  "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
  "plans": [
    {
      "name": "PRD_0000000020_PL_000001",
      "display_name": "basic",
      "is_active": "Y",
      "initialPhases": [
        {
          "type": "TRIAL",
          "duration": {
            "unit": "DAYS",
            "number": 30
          },
          "recurring": null,
          "fixed": {
            "fixedPrice": [
              {
                "currency": "USD",
                "value": 0
              }
            ]
          },
          "usages": null
        },
        {
          "type": "DISCOUNT",
          "duration": {
            "unit": "MONTHS",
            "number": 2
          },
          "recurring": {
            "billingPeriod": "MONTHLY",
            "recurringPrice": [
              {
                "currency": "USD",
                "value": 8
              }
            ]
          },
          "fixed": null,
          "usages": null
        }
      ],
      "finalPhase": {
        "type": "EVERGREEN",
        "duration": {
          "unit": "UNLIMITED",
          "number": null
        },
        "recurring": {
          "billingPeriod": "MONTHLY",
          "recurringPrice": [
            {
              "currency": "USD",
              "value": 10
            }
          ]
        },
        "fixed": null,
        "usages": [
          {
            "name": "PRD_0000000020_USG_000001",
            "display_name": "storage-usage",
            "billingMode": "IN_ARREAR",
            "usageType": "CONSUMABLE",
            "billingPeriod": "MONTHLY",
            "tiers": [
              {
                "unit": "storage",
                "size": 10,
                "prices": [
                  {
                    "currency": "USD",
                    "value": 3
                  }
                ],
                "max": 100
              },
              {
                "unit": "storage",
                "size": 10,
                "prices": [
                  {
                    "currency": "USD",
                    "value": 2
                  }
                ],
                "max": 500
              }
            ]
          }
        ]
      },
      "number_of_subscriptions_referenced_by_version": 0,
      "number_of_subscriptions": 0
    }
  ],
  "reg_dt": "2017-03-26"
}
```

GET /rest/v1/product/{productId}/version/{version}


### Description
product 의 version 을 조회한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**productId**  <br>*required*|string|
|**Path**|**version**  <br>*required*|number|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[ProductVersionJson](#productversionjson)|
|**400**|Invalid product version supplied|No Content|
|**404**|product version not found|No Content|


### Produces

* `application/json`


<a name="updateproductversion"></a>
## Update product version

```
PUT /rest/v1/product/{productId}/version/{version}

Request Example

curl -X PUT 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "effective_date": "2017-03-20",
  "plans": [
    {
      "name": "PRD_0000000020_PL_000001",
      "display_name": "basic",
      "is_active": "Y",
      "initialPhases": [
        {
          "type": "TRIAL",
          "duration": {
            "unit": "DAYS",
            "number": 30
          },
          "recurring": null,
          "fixed": {
            "fixedPrice": [
              {
                "currency": "USD",
                "value": 0
              }
            ]
          },
          "usages": null
        },
        {
          "type": "DISCOUNT",
          "duration": {
            "unit": "MONTHS",
            "number": 2
          },
          "recurring": {
            "billingPeriod": "MONTHLY",
            "recurringPrice": [
              {
                "currency": "USD",
                "value": 8
              }
            ]
          },
          "fixed": null,
          "usages": null
        }
      ],
      "finalPhase": {
        "type": "EVERGREEN",
        "duration": {
          "unit": "UNLIMITED",
          "number": null
        },
        "recurring": {
          "billingPeriod": "MONTHLY",
          "recurringPrice": [
            {
              "currency": "USD",
              "value": 10
            }
          ]
        },
        "fixed": null,
        "usages": [
          {
            "name": "PRD_0000000020_USG_000001",
            "display_name": "storage-usage",
            "billingMode": "IN_ARREAR",
            "usageType": "CONSUMABLE",
            "billingPeriod": "MONTHLY",
            "tiers": [
              {
                "unit": "storage",
                "size": 10,
                "prices": [
                  {
                    "currency": "USD",
                    "value": 3
                  }
                ],
                "max": 100
              },
              {
                "unit": "storage",
                "size": 10,
                "prices": [
                  {
                    "currency": "USD",
                    "value": 2
                  }
                ],
                "max": 500
              }
            ]
          }
        ]
      }
    }
  ]
}' 
'http://localhost:18080/rest/v1/product/PRD_0000000020/version/1'


Reponse Example

{
  "id": 23,
  "product_id": "PRD_0000000020",
  "version": 1,
  "effective_date": "2017-03-20",
  "is_current": "Y",
  "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
  "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
  "plans": [
    {
      "name": "PRD_0000000020_PL_000001",
      "display_name": "basic",
      "is_active": "Y",
      "initialPhases": [
        {
          "type": "TRIAL",
          "duration": {
            "unit": "DAYS",
            "number": 30
          },
          "recurring": null,
          "fixed": {
            "fixedPrice": [
              {
                "currency": "USD",
                "value": 0
              }
            ]
          },
          "usages": null
        },
        {
          "type": "DISCOUNT",
          "duration": {
            "unit": "MONTHS",
            "number": 2
          },
          "recurring": {
            "billingPeriod": "MONTHLY",
            "recurringPrice": [
              {
                "currency": "USD",
                "value": 8
              }
            ]
          },
          "fixed": null,
          "usages": null
        }
      ],
      "finalPhase": {
        "type": "EVERGREEN",
        "duration": {
          "unit": "UNLIMITED",
          "number": null
        },
        "recurring": {
          "billingPeriod": "MONTHLY",
          "recurringPrice": [
            {
              "currency": "USD",
              "value": 10
            }
          ]
        },
        "fixed": null,
        "usages": [
          {
            "name": "PRD_0000000020_USG_000001",
            "display_name": "storage-usage",
            "billingMode": "IN_ARREAR",
            "usageType": "CONSUMABLE",
            "billingPeriod": "MONTHLY",
            "tiers": [
              {
                "unit": "storage",
                "size": 10,
                "prices": [
                  {
                    "currency": "USD",
                    "value": 3
                  }
                ],
                "max": 100
              },
              {
                "unit": "storage",
                "size": 10,
                "prices": [
                  {
                    "currency": "USD",
                    "value": 2
                  }
                ],
                "max": 500
              }
            ]
          }
        ]
      },
      "number_of_subscriptions_referenced_by_version": 0,
      "number_of_subscriptions": 0
    }
  ],
  "reg_dt": "2017-03-26"
}
```

PUT /rest/v1/product/{productId}/version/{version}


### Description
product version 정보를 업데이트한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**productId**  <br>*required*|string|
|**Path**|**version**  <br>*required*|number|
|**Body**|**body**  <br>*optional*|[ProductVersionJson](#productversionjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[ProductVersionJson](#productversionjson)|
|**400**|Invalid product version data supplied|No Content|
|**404**|product version not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="deleteproductversion"></a>
## Remove product version

```
DELETE /rest/v1/product/{productId}/version/{version}

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/product/PRD_0000000020/version/1'


Reponse Example

204 No Content
```

DELETE /rest/v1/product/{productId}/version/{version}


### Description
product version 을 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**productId**  <br>*required*|string|
|**Path**|**version**  <br>*required*|number|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|successful operation|No Content|
|**400**|Invalid product version supplied|No Content|
|**404**|product version not found|No Content|


### Produces

* `application/json`



<a name="getaccountssales"></a>
## List product sales history
```
GET /rest/v1/product/{productId}/sales/pagination

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: 6925a6d1-a6b7-4298-944b-b29945bd4872' 
'http://localhost:18080/rest/v1/product/PRD_0000000001/sales/pagination?offset=0&limit=1'


Response Example

[
  {
    "record_id": 262,
    "subscription_id": "ae57d7c3-b99c-4ea3-9523-d55bcae294ed",
    "tenant_id": "a31a66e0-ed86-494c-983a-75df5894069d",
    "organization_id": "6925a6d1-a6b7-4298-944b-b29945bd4872",
    "buyer_id": "64daf4bd-447c-4f10-963d-055c8ce2cc96",
    "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3",
    "product_id": "PRD_0000000001",
    "version": 1,
    "plan_name": "PRD_0000000001_PL_000001",
    "usage_name": null,
    "ratio": 5,
    "amount": 0.5,
    "original_amount": 10,
    "currency": "USD",
    "invoice_id": "907085d7-a76f-4803-81da-e5b1bbdbcbfc",
    "invoice_item_id": "987e7985-a05c-48ab-95f3-cece3b2b8ca8",
    "linked_invoice_item_id": null,
    "invoice_item_type": "RECURRING",
    "price_type": "RECURRING",
    "transaction_type": "CREATION",
    "format_date": "2017-12-20",
    "created_date": "2017-12-20",
    "notes": null
  }
]
```


### Description
제품의 판매 이력을 페이징 처리하여 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**productId**  <br>*required*|string||
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [ProductDistributionHistory](#productdistributionhistory) > array|


### Produces

* `application/json`


<a name="searchaccountssales"></a>
## Search product sales history
```
GET /rest/v1/product/{productId}/sales/search/{searchKey}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: 6925a6d1-a6b7-4298-944b-b29945bd4872' 
'http://localhost:18080/rest/v1/product/PRD_0000000001/sales/search/PRD_0000000001_PL_000001?offset=0&limit=1'


Response Example

[
  {
    "record_id": 262,
    "subscription_id": "ae57d7c3-b99c-4ea3-9523-d55bcae294ed",
    "tenant_id": "a31a66e0-ed86-494c-983a-75df5894069d",
    "organization_id": "6925a6d1-a6b7-4298-944b-b29945bd4872",
    "buyer_id": "64daf4bd-447c-4f10-963d-055c8ce2cc96",
    "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3",
    "product_id": "PRD_0000000001",
    "version": 1,
    "plan_name": "PRD_0000000001_PL_000001",
    "usage_name": null,
    "ratio": 5,
    "amount": 0.5,
    "original_amount": 10,
    "currency": "USD",
    "invoice_id": "907085d7-a76f-4803-81da-e5b1bbdbcbfc",
    "invoice_item_id": "987e7985-a05c-48ab-95f3-cece3b2b8ca8",
    "linked_invoice_item_id": null,
    "invoice_item_type": "RECURRING",
    "price_type": "RECURRING",
    "transaction_type": "CREATION",
    "format_date": "2017-12-20",
    "created_date": "2017-12-20",
    "notes": null
  }
]
```


### Description
주어진 검색어에 해당하는 제품 판매 이력을 페이징 처리하여 반환한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**productId**  <br>*required*|string||
|**Path**|**searchKey**  <br>*required*|string||
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [ProductDistributionHistory](#productdistributionhistory) > array|


### Produces

* `application/json`


<a name="getproductsalessummary"></a>
## get product sales summary per date
```
GET /rest/v1/product/{productId}/sales/summary

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: 6925a6d1-a6b7-4298-944b-b29945bd4872' 
'http://localhost:18080/rest/v1/product/PRD_0000000001/sales/summary?period=MONTH&start_date=2017-01-01&end_date=2017-12-31'


Response Example

{
  "refund": {
    "summary": {
      "total": {
        "USD": -22,
        "KRW": -7000
      },
      "per_usage_name": {
        "PRD_0000000001_USG_000001": {
          "USD": -10,
          "KRW": -3000
        }
      },
      "per_vendor_id": {
        "881c5072-5a7d-4b35-8ade-25939da579e3": {
          "USD": -0.6932,
          "KRW": -220
        },
        "efb27bd3-23f9-4a65-8d85-0503030a3b81": {
          "USD": -2.138,
          "KRW": -701.6
        },
        "organization": {
          "USD": -19.1688,
          "KRW": -6078.4
        }
      },
      "per_product_id": {
        "PRD_0000000001": {
          "USD": -22,
          "KRW": -7000
        }
      },
      "per_plan_name": {
        "PRD_0000000001_PL_000001": {
          "USD": -22,
          "KRW": -7000
        }
      },
      "per_price_type": {
        "USAGE": {
          "USD": -10,
          "KRW": -3000
        },
        "RECURRING": {
          "USD": -12,
          "KRW": -4000
        }
      }
    },
    "per_date": {
      "2017-08": [
        {
          "usage_name": "",
          "amount": {
            "USD": -0.3612,
            "KRW": -120.4
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "PRD_0000000001_USG_000001",
          "amount": {
            "USD": -0.332,
            "KRW": -99.6
          },
          "price_type": "USAGE",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": -1.806,
            "KRW": -602
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "efb27bd3-23f9-4a65-8d85-0503030a3b81"
        },
        {
          "usage_name": "PRD_0000000001_USG_000001",
          "amount": {
            "USD": -0.332,
            "KRW": -99.6
          },
          "price_type": "USAGE",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "efb27bd3-23f9-4a65-8d85-0503030a3b81"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": -9.8328,
            "KRW": -3277.6
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "organization"
        },
        {
          "usage_name": "PRD_0000000001_USG_000001",
          "amount": {
            "USD": -9.336,
            "KRW": -2800.8
          },
          "price_type": "USAGE",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "organization"
        }
      ]
    }
  },
  "credit": {
    "summary": {
      "total": {},
      "per_usage_name": {},
      "per_vendor_id": {},
      "per_product_id": {},
      "per_plan_name": {},
      "per_price_type": {}
    },
    "per_date": {}
  },
  "end_date": "2017-12-31",
  "withdraw": {
    "summary": {
      "total": {},
      "per_usage_name": {},
      "per_vendor_id": {},
      "per_product_id": {},
      "per_plan_name": {},
      "per_price_type": {}
    },
    "per_date": {}
  },
  "sales": {
    "summary": {
      "total": {
        "USD": 810.58,
        "KRW": 104000
      },
      "per_usage_name": {
        "PRD_0000000001_USG_000001": {
          "USD": 46,
          "KRW": 34000
        }
      },
      "per_vendor_id": {
        "881c5072-5a7d-4b35-8ade-25939da579e3": {
          "USD": 27.772619,
          "KRW": 3235.8
        },
        "efb27bd3-23f9-4a65-8d85-0503030a3b81": {
          "USD": 116.515295,
          "KRW": 11663.8
        },
        "organization": {
          "USD": 666.292086,
          "KRW": 89100.4
        }
      },
      "per_product_id": {
        "PRD_0000000001": {
          "USD": 810.58,
          "KRW": 104000
        }
      },
      "per_plan_name": {
        "PRD_0000000001_PL_000002": {
          "USD": 39
        },
        "PRD_0000000001_PL_000003": {
          "USD": 48.39
        },
        "PRD_0000000001_PL_000001": {
          "USD": 723.19,
          "KRW": 104000
        }
      },
      "per_price_type": {
        "USAGE": {
          "USD": 46,
          "KRW": 34000
        },
        "RECURRING": {
          "USD": 749.58,
          "KRW": 70000
        },
        "FIXED": {
          "USD": 15
        }
      }
    },
    "per_date": {
      "2017-06": [
        {
          "usage_name": "",
          "amount": {
            "USD": 3.5518,
            "KRW": 301
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 17.759,
            "KRW": 1505
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "efb27bd3-23f9-4a65-8d85-0503030a3b81"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 96.6892,
            "KRW": 8194
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "organization"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 0
          },
          "price_type": "FIXED",
          "plan_name": "PRD_0000000001_PL_000003",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 0
          },
          "price_type": "FIXED",
          "plan_name": "PRD_0000000001_PL_000003",
          "product_id": "PRD_0000000001",
          "vendor_id": "efb27bd3-23f9-4a65-8d85-0503030a3b81"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 0
          },
          "price_type": "FIXED",
          "plan_name": "PRD_0000000001_PL_000003",
          "product_id": "PRD_0000000001",
          "vendor_id": "organization"
        }
      ],
      "2017-10": [
        {
          "usage_name": "",
          "amount": {
            "USD": 1.403,
            "KRW": 301
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 6.015,
            "KRW": 1505
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "efb27bd3-23f9-4a65-8d85-0503030a3b81"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 32.582,
            "KRW": 8194
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "organization"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 0.301
          },
          "price_type": "FIXED",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 0.65
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000002",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 1.505
          },
          "price_type": "FIXED",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "efb27bd3-23f9-4a65-8d85-0503030a3b81"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 1.95
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000002",
          "product_id": "PRD_0000000001",
          "vendor_id": "efb27bd3-23f9-4a65-8d85-0503030a3b81"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 8.194
          },
          "price_type": "FIXED",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "organization"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 10.4
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000002",
          "product_id": "PRD_0000000001",
          "vendor_id": "organization"
        }
      ],
      "2017-11": [
        {
          "usage_name": "",
          "amount": {
            "USD": 1.102,
            "KRW": 301
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 0.65
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000002",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 4.51,
            "KRW": 1505
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "efb27bd3-23f9-4a65-8d85-0503030a3b81"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 1.95
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000002",
          "product_id": "PRD_0000000001",
          "vendor_id": "efb27bd3-23f9-4a65-8d85-0503030a3b81"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 24.388,
            "KRW": 8194
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "organization"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 10.4
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000002",
          "product_id": "PRD_0000000001",
          "vendor_id": "organization"
        }
      ],
      "2017-12": [
        {
          "usage_name": "",
          "amount": {
            "USD": 2.607,
            "KRW": 301
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 0.65
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000002",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 12.035,
            "KRW": 1505
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "efb27bd3-23f9-4a65-8d85-0503030a3b81"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 1.95
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000002",
          "product_id": "PRD_0000000001",
          "vendor_id": "efb27bd3-23f9-4a65-8d85-0503030a3b81"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 65.358,
            "KRW": 8194
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "organization"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 10.4
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000002",
          "product_id": "PRD_0000000001",
          "vendor_id": "organization"
        }
      ],
      "2017-07": [
        {
          "usage_name": "",
          "amount": {
            "USD": 0.25
          },
          "price_type": "FIXED",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 5.223933
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 0.75
          },
          "price_type": "FIXED",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "efb27bd3-23f9-4a65-8d85-0503030a3b81"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 24.119665
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "efb27bd3-23f9-4a65-8d85-0503030a3b81"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 4
          },
          "price_type": "FIXED",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "organization"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 130.986402
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "organization"
        }
      ],
      "2017-08": [
        {
          "usage_name": "",
          "amount": {
            "USD": 1.9195
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000003",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 5.7585
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000003",
          "product_id": "PRD_0000000001",
          "vendor_id": "efb27bd3-23f9-4a65-8d85-0503030a3b81"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 30.712
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000003",
          "product_id": "PRD_0000000001",
          "vendor_id": "organization"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 4.549052,
            "KRW": 602
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "PRD_0000000001_USG_000001",
          "amount": {
            "USD": 1.5272,
            "KRW": 1128.8
          },
          "price_type": "USAGE",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 21.74526,
            "KRW": 3010
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "efb27bd3-23f9-4a65-8d85-0503030a3b81"
        },
        {
          "usage_name": "PRD_0000000001_USG_000001",
          "amount": {
            "USD": 1.5272,
            "KRW": 1128.8
          },
          "price_type": "USAGE",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "efb27bd3-23f9-4a65-8d85-0503030a3b81"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 118.225688,
            "KRW": 16388
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "organization"
        },
        {
          "usage_name": "PRD_0000000001_USG_000001",
          "amount": {
            "USD": 42.9456,
            "KRW": 31742.4
          },
          "price_type": "USAGE",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "organization"
        }
      ],
      "2017-09": [
        {
          "usage_name": "",
          "amount": {
            "USD": 2.888134,
            "KRW": 301
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 0.5
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000003",
          "product_id": "PRD_0000000001",
          "vendor_id": "881c5072-5a7d-4b35-8ade-25939da579e3"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 13.44067,
            "KRW": 1505
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "efb27bd3-23f9-4a65-8d85-0503030a3b81"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 1.5
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000003",
          "product_id": "PRD_0000000001",
          "vendor_id": "efb27bd3-23f9-4a65-8d85-0503030a3b81"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 73.011196,
            "KRW": 8194
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000001",
          "product_id": "PRD_0000000001",
          "vendor_id": "organization"
        },
        {
          "usage_name": "",
          "amount": {
            "USD": 8
          },
          "price_type": "RECURRING",
          "plan_name": "PRD_0000000001_PL_000003",
          "product_id": "PRD_0000000001",
          "vendor_id": "organization"
        }
      ]
    }
  },
  "start_date": "2017-01-01",
  "currencies": [
    "KRW",
    "USD"
  ]
}
```


### Description
제품의 판매대금 합계를 기간별로 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**productId**  <br>*required*|string||
|**Query**|**end_date**  <br>*optional*|string||
|**Query**|**period**  <br>*optional*|enum (DAY, MONTH, YEAR)|`"DAY"`|
|**Query**|**plan_name**  <br>*optional*|string||
|**Query**|**start_date**  <br>*optional*|string||
|**Query**|**usage_name**  <br>*optional*|string||
|**Query**|**vendor_id**  <br>*optional*|string||


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[SalesPerDateSummaryJson](#salesperdatesummaryjson)|
|**400**|Invalid account id supplied|No Content|
|**404**|Product not found|No Content|


### Produces

* `application/json`


<a name="retry_resource"></a>
# Retry

<a name="updateretryrule"></a>
## Update retry rule

```
POST /rest/v1/retry

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "retry": "1,1,1"
}' 
'http://localhost:18080/rest/v1/retry'


Reponse Example

201 Created
```

POST /rest/v1/retry


### Description
결제 재시도 규칙을 업데이트 한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Body**|**body**  <br>*required*|[RetryRuleJson](#retryrulejson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|successful operation|No Content|
|**400**|Invalid Request|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getretryrule"></a>
## Get retry rule

```
GET /rest/v1/retry

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/retry'


Reponse Example

{
  "retry": "1,1,1"
}
```

GET /rest/v1/retry


### Description
결제 재시도 규칙을 조회한다.


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[RetryRuleJson](#retryrulejson)|
|**400**|Invalid Request|No Content|


### Produces

* `application/json`


<a name="rule_resource"></a>
# Rule

<a name="updatebillingrule"></a>
## Update billing rule

```
POST /rest/v1/rule

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "billingAlignment": [
    {
      "productCategory": "BASE",
      "billingAlignment": "ACCOUNT"
    },
    {
      "productCategory": "ADD_ON",
      "billingAlignment": "BUNDLE"
    },
    {
      "billingAlignment": "ACCOUNT"
    }
  ],
  "createAlignment": [
    {
      "planAlignmentCreate": "START_OF_BUNDLE"
    }
  ],
  "cancelPolicy": [
    {
      "phaseType": "TRIAL",
      "billingActionPolicy": "IMMEDIATE"
    },
    {
      "billingActionPolicy": "END_OF_TERM"
    }
  ],
  "changePolicy": [
    {
      "phaseType": "TRIAL",
      "billingActionPolicy": "IMMEDIATE"
    },
    {
      "billingActionPolicy": "END_OF_TERM"
    }
  ],
  "changeAlignment": [
    {
      "toProductCategory": "ADD_ON",
      "planAlignmentChange": "START_OF_BUNDLE"
    },
    {
      "planAlignmentChange": "START_OF_SUBSCRIPTION"
    }
  ],
  "recurringBillingMode": "IN_ADVANCE"
}' 
'http://localhost:18080/rest/v1/rule'


Reponse Example

201 Created
```

POST /rest/v1/rule


### Description
빌링 규칙을 업데이트 한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Body**|**body**  <br>*required*|[BillingRuleJson](#billingrulejson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|successful operation|No Content|
|**400**|Invalid Request|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getbillingrule"></a>
## Get billing rule

```
GET /rest/v1/rule

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/rule'


Reponse Example

{
  "billingAlignment": [
    {
      "productCategory": "BASE",
      "billingAlignment": "ACCOUNT"
    },
    {
      "productCategory": "ADD_ON",
      "billingAlignment": "BUNDLE"
    },
    {
      "billingAlignment": "ACCOUNT"
    }
  ],
  "createAlignment": [
    {
      "planAlignmentCreate": "START_OF_BUNDLE"
    }
  ],
  "cancelPolicy": [
    {
      "phaseType": "TRIAL",
      "billingActionPolicy": "IMMEDIATE"
    },
    {
      "billingActionPolicy": "END_OF_TERM"
    }
  ],
  "changePolicy": [
    {
      "phaseType": "TRIAL",
      "billingActionPolicy": "IMMEDIATE"
    },
    {
      "billingActionPolicy": "END_OF_TERM"
    }
  ],
  "changeAlignment": [
    {
      "toProductCategory": "ADD_ON",
      "planAlignmentChange": "START_OF_BUNDLE"
    },
    {
      "planAlignmentChange": "START_OF_SUBSCRIPTION"
    }
  ],
  "recurringBillingMode": "IN_ADVANCE"
}
```

GET /rest/v1/rule


### Description
빌링 규칙을 조회한다.


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[BillingRuleJson](#billingrulejson)|
|**400**|Invalid Request|No Content|


### Produces

* `application/json`


<a name="subscriptions_resource"></a>
# Subscriptions

<a name="createentitlement"></a>
## Create an entitlement

```
POST /rest/v1/subscriptions

Request Example

BASIC 구독 생성)

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "accountId": "9c3f0bea-d1e1-40ae-98bf-81d317885288",
  "planName": "PRD_0000000017_PL_000002"
}' 
'http://localhost:18080/rest/v1/subscriptions?migrated=false&callCompletion=false&callTimeoutSec=3'



ADD_ON 구독 생성)

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "accountId": "9c3f0bea-d1e1-40ae-98bf-81d317885288",
  "bundleId": "636d06f3-a974-4904-baee-b34bb0403f47",
  "productCategory": "ADD_ON",
  "planName": "PRD_0000000021_PL_000001"
}' 
'http://localhost:18080/rest/v1/subscriptions?migrated=false&callCompletion=false&callTimeoutSec=3'


Reponse Example

201 Created
```

POST /rest/v1/subscriptions


### Description
BASE 또는 ADD_ON 구독을 생성한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string||
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string||
|**Header**|**X-Killbill-Reason**  <br>*optional*|string||
|**Query**|**bcd**  <br>*optional*|integer (int32)||
|**Query**|**billingDate**  <br>*optional*|string||
|**Query**|**callCompletion**  <br>*optional*|boolean|`"false"`|
|**Query**|**callTimeoutSec**  <br>*optional*|integer (int64)|`3`|
|**Query**|**entitlementDate**  <br>*optional*|string||
|**Query**|**migrated**  <br>*optional*|boolean|`"false"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**requestedDate**  <br>*optional*|string||
|**Body**|**body**  <br>*optional*|[SubscriptionJson](#subscriptionjson)||


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid entitlement supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="createentitlementwithaddons"></a>
## Create an entitlement with addOn products

```
POST /rest/v1/subscriptions/createEntitlementWithAddOns

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '[
  {
  "accountId": "9c3f0bea-d1e1-40ae-98bf-81d317885288",
  "productCategory": "BASE",
  "planName": "PRD_0000000017_PL_000002"
},
{
  "accountId": "9c3f0bea-d1e1-40ae-98bf-81d317885288",
  "productCategory": "ADD_ON",
  "planName": "PRD_0000000021_PL_000001"
}
]' 'http://localhost:18080/rest/v1/subscriptions/createEntitlementWithAddOns?migrated=false&callCompletion=false&callTimeoutSec=3'


Reponse Example

201 Created
```

POST /rest/v1/subscriptions/createEntitlementWithAddOns


### Description
ADD_ON 구독이 포함된 BASE 구독을 생성한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string||
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string||
|**Header**|**X-Killbill-Reason**  <br>*optional*|string||
|**Query**|**billingDate**  <br>*optional*|string||
|**Query**|**callCompletion**  <br>*optional*|boolean|`"false"`|
|**Query**|**callTimeoutSec**  <br>*optional*|integer (int64)|`3`|
|**Query**|**entitlementDate**  <br>*optional*|string||
|**Query**|**migrated**  <br>*optional*|boolean|`"false"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**requestedDate**  <br>*optional*|string||
|**Body**|**body**  <br>*optional*|< [SubscriptionJson](#subscriptionjson) > array||


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid entitlement supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="createentitlementswithaddons"></a>
## Create multiple entitlements with addOn products

```
POST /rest/v1/subscriptions/createEntitlementsWithAddOns

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '[
  {
    "baseEntitlementAndAddOns": [
  {
  "accountId": "9c3f0bea-d1e1-40ae-98bf-81d317885288",
  "productCategory": "BASE",
  "planName": "PRD_0000000017_PL_000002"
},
{
  "accountId": "9c3f0bea-d1e1-40ae-98bf-81d317885288",
  "productCategory": "ADD_ON",
  "planName": "PRD_0000000021_PL_000001"
}
]
  }
]' 
'http://localhost:18080/rest/v1/subscriptions/createEntitlementsWithAddOns?migrated=false&callCompletion=false&callTimeoutSec=3'


Reponse Example

201 Created
```

POST /rest/v1/subscriptions/createEntitlementsWithAddOns


### Description
ADD_ON 구독이 포함된 BASE 구독을 다수 생성한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string||
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string||
|**Header**|**X-Killbill-Reason**  <br>*optional*|string||
|**Query**|**billingDate**  <br>*optional*|string||
|**Query**|**callCompletion**  <br>*optional*|boolean|`"false"`|
|**Query**|**callTimeoutSec**  <br>*optional*|integer (int64)|`3`|
|**Query**|**entitlementDate**  <br>*optional*|string||
|**Query**|**migrated**  <br>*optional*|boolean|`"false"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**requestedDate**  <br>*optional*|string||
|**Body**|**body**  <br>*optional*|< [BulkBaseSubscriptionAndAddOnsJson](#bulkbasesubscriptionandaddonsjson) > array||


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid entitlements supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getentitlement"></a>
## Retrieve a subscription by id

```
GET /rest/v1/subscriptions/{subscriptionId}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/subscriptions/429b8ae3-d431-427b-876c-03d9d51d8b52?audit=NONE'


Reponse Example

{
  "accountId": "9c3f0bea-d1e1-40ae-98bf-81d317885288",
  "bundleId": "636d06f3-a974-4904-baee-b34bb0403f47",
  "subscriptionId": "429b8ae3-d431-427b-876c-03d9d51d8b52",
  "externalKey": "636d06f3-a974-4904-baee-b34bb0403f47",
  "startDate": "2017-03-26",
  "productName": "PRD_0000000017",
  "productCategory": "BASE",
  "billingPeriod": "MONTHLY",
  "phaseType": "EVERGREEN",
  "priceList": "DEFAULT",
  "planName": "PRD_0000000017_PL_000002",
  "state": "ACTIVE",
  "sourceType": "NATIVE",
  "cancelledDate": null,
  "chargedThroughDate": "2017-06-24",
  "billingStartDate": "2017-03-26",
  "billingEndDate": null,
  "billCycleDayLocal": 24,
  "events": [
    {
      "eventId": "6eb172c4-7faa-457e-bfc8-3724324822d5",
      "billingPeriod": "MONTHLY",
      "product": "PRD_0000000017",
      "priceList": "DEFAULT",
      "eventType": "START_ENTITLEMENT",
      "isBlockedBilling": false,
      "isBlockedEntitlement": false,
      "serviceName": "entitlement-service",
      "serviceStateName": "ENT_STARTED",
      "phase": "PRD_0000000017_PL_000002-evergreen",
      "auditLogs": [],
      "effectiveDate": "2017-03-26"
    },
    {
      "eventId": "f83cb776-b877-47c3-9c99-a525d92a9590",
      "billingPeriod": "MONTHLY",
      "product": "PRD_0000000017",
      "priceList": "DEFAULT",
      "eventType": "START_BILLING",
      "isBlockedBilling": false,
      "isBlockedEntitlement": false,
      "serviceName": "billing-service",
      "serviceStateName": "START_BILLING",
      "phase": "PRD_0000000017_PL_000002-evergreen",
      "auditLogs": [],
      "effectiveDate": "2017-03-26"
    }
  ],
  "priceOverrides": [
    {
      "phaseName": "PRD_0000000017_PL_000002-evergreen",
      "phaseType": "EVERGREEN",
      "fixedPrice": null,
      "recurringPrice": 80
    }
  ],
  "auditLogs": []
}
```

GET /rest/v1/subscriptions/{subscriptionId}


### Description
아이디로 구독을 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**subscriptionId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[SubscriptionJson](#subscriptionjson)|
|**400**|Invalid subscription id supplied|No Content|
|**404**|Subscription not found|No Content|


### Produces

* `application/json`


<a name="changeentitlementplan"></a>
## Change entitlement plan

```
PUT /rest/v1/subscriptions/{subscriptionId}

Request Example

curl -X PUT 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "accountId": "9c3f0bea-d1e1-40ae-98bf-81d317885288",
  "planName": "PRD_0000000017_PL_000001"
}' 
'http://localhost:18080/rest/v1/subscriptions/429b8ae3-d431-427b-876c-03d9d51d8b52?callCompletion=false&callTimeoutSec=3'


Reponse Example

{
  "accountId": "9c3f0bea-d1e1-40ae-98bf-81d317885288",
  "bundleId": "636d06f3-a974-4904-baee-b34bb0403f47",
  "subscriptionId": "429b8ae3-d431-427b-876c-03d9d51d8b52",
  "externalKey": "636d06f3-a974-4904-baee-b34bb0403f47",
  "startDate": "2017-03-26",
  "productName": "PRD_0000000017",
  "productCategory": "BASE",
  "billingPeriod": "MONTHLY",
  "phaseType": "EVERGREEN",
  "priceList": "DEFAULT",
  "planName": "PRD_0000000017_PL_000002",
  "state": "ACTIVE",
  "sourceType": "NATIVE",
  "cancelledDate": null,
  "chargedThroughDate": "2017-06-24",
  "billingStartDate": "2017-03-26",
  "billingEndDate": null,
  "billCycleDayLocal": 24,
  "events": [
    {
      "eventId": "6eb172c4-7faa-457e-bfc8-3724324822d5",
      "billingPeriod": "MONTHLY",
      "product": "PRD_0000000017",
      "priceList": "DEFAULT",
      "eventType": "START_ENTITLEMENT",
      "isBlockedBilling": false,
      "isBlockedEntitlement": false,
      "serviceName": "entitlement-service",
      "serviceStateName": "ENT_STARTED",
      "phase": "PRD_0000000017_PL_000001-evergreen",
      "auditLogs": [],
      "effectiveDate": "2017-03-26"
    },
    {
      "eventId": "f83cb776-b877-47c3-9c99-a525d92a9590",
      "billingPeriod": "MONTHLY",
      "product": "PRD_0000000017",
      "priceList": "DEFAULT",
      "eventType": "START_BILLING",
      "isBlockedBilling": false,
      "isBlockedEntitlement": false,
      "serviceName": "billing-service",
      "serviceStateName": "START_BILLING",
      "phase": "PRD_0000000017_PL_000002-evergreen",
      "auditLogs": [],
      "effectiveDate": "2017-03-26"
    },
    {
      "eventId": "d3f9ec50-23d9-465b-ab53-203fa5243378",
      "billingPeriod": "MONTHLY",
      "product": "PRD_0000000017",
      "priceList": "DEFAULT",
      "eventType": "CHANGE",
      "isBlockedBilling": false,
      "isBlockedEntitlement": false,
      "serviceName": "entitlement+billing-service",
      "serviceStateName": "CHANGE",
      "phase": "PRD_0000000017_PL_000001-evergreen",
      "auditLogs": [],
      "effectiveDate": "2017-06-24"
    }
  ],
  "priceOverrides": [
    {
      "phaseName": "PRD_0000000017_PL_000002-evergreen",
      "phaseType": "EVERGREEN",
      "fixedPrice": null,
      "recurringPrice": 80
    }
  ],
  "auditLogs": []
}
```

PUT /rest/v1/subscriptions/{subscriptionId}


### Description
구독의 플랜을 변경한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string||
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string||
|**Header**|**X-Killbill-Reason**  <br>*optional*|string||
|**Path**|**subscriptionId**  <br>*required*|string||
|**Query**|**billingPolicy**  <br>*optional*|string||
|**Query**|**callCompletion**  <br>*optional*|boolean|`"false"`|
|**Query**|**callTimeoutSec**  <br>*optional*|integer (int64)|`3`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**requestedDate**  <br>*optional*|string||
|**Body**|**body**  <br>*optional*|[SubscriptionJson](#subscriptionjson)||


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid subscription id supplied|No Content|
|**404**|Entitlement not found|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="cancelentitlementplan"></a>
## Cancel an entitlement plan

```
DELETE /rest/v1/subscriptions/{subscriptionId}

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/subscriptions/6d306540-528e-466c-9f3a-7145ca855ba7?useRequestedDateForBilling=true&billingPolicy=IMMEDIATE&entitlementPolicy=IMMEDIATE'


Reponse Example

200 Deleted
```

DELETE /rest/v1/subscriptions/{subscriptionId}


### Description
구독을 취소(cancel) 한다. 취소된 구독은 완전히 종료된 것으로 재시작 할 수 없다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string||
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string||
|**Header**|**X-Killbill-Reason**  <br>*optional*|string||
|**Path**|**subscriptionId**  <br>*required*|string||
|**Query**|**billingPolicy**  <br>*optional*|string||
|**Query**|**callCompletion**  <br>*optional*|boolean|`"false"`|
|**Query**|**callTimeoutSec**  <br>*optional*|integer (int64)|`5`|
|**Query**|**entitlementPolicy**  <br>*optional*|string||
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**requestedDate**  <br>*optional*|string||
|**Query**|**useRequestedDateForBilling**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid subscription id supplied|No Content|
|**404**|Entitlement not found|No Content|


### Produces

* `application/json`


<a name="updatesubscriptionbcd"></a>
## Update the BCD associated to a subscription
```
PUT /rest/v1/subscriptions/{subscriptionId}/bcd
```


### Description
구독의 결제 주기 날짜를 변경한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**subscriptionId**  <br>*required*|string|
|**Query**|**effectiveFromDate**  <br>*optional*|string|
|**Body**|**body**  <br>*optional*|[SubscriptionJson](#subscriptionjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid entitlement supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="addsubscriptionblockingstate"></a>
## Block a subscription
```
PUT /rest/v1/subscriptions/{subscriptionId}/block
```


### Description
구독의 Block 상태를 설정한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**subscriptionId**  <br>*required*|string|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Query**|**requestedDate**  <br>*optional*|string|
|**Body**|**body**  <br>*optional*|[BlockingStateJson](#blockingstatejson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid subscription id supplied|No Content|
|**404**|Subscription not found|No Content|


### Consumes

* `application/json`


<a name="createsubscriptioncustomfields"></a>
## Add custom fields to subscription

```
POST /rest/v1/subscriptions/{subscriptionId}/customFields

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '[
  {
    "name": "key1",
    "value": "value1"
  }
]' 
'http://localhost:18080/rest/v1/subscriptions/88ace3ef-46e0-4019-bff9-51569c2acf99/customFields'


Reponse Example

201 Created
```

POST /rest/v1/subscriptions/{subscriptionId}/customFields


### Description
구독에 커스텀 필드를 추가한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**subscriptionId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|< [CustomFieldJson](#customfieldjson) > array|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid subscription id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getsubscriptioncustomfields"></a>
## Retrieve subscription custom fields

```
GET /rest/v1/subscriptions/{subscriptionId}/customFields

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/subscriptions/88ace3ef-46e0-4019-bff9-51569c2acf99/customFields?audit=NONE'


Reponse Example

[
  {
    "customFieldId": "b61ff3ea-62b7-4ffa-804d-bf3620bbbc1c",
    "objectId": "88ace3ef-46e0-4019-bff9-51569c2acf99",
    "objectType": "SUBSCRIPTION",
    "name": "key1",
    "value": "value1",
    "auditLogs": []
  }
]
```

GET /rest/v1/subscriptions/{subscriptionId}/customFields


### Description
구독의 커스텀 필드를 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**subscriptionId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [CustomFieldJson](#customfieldjson) > array|
|**400**|Invalid subscription id supplied|No Content|


### Produces

* `application/json`


<a name="deletesubscriptioncustomfields"></a>
## Remove custom fields from subscription

```
DELETE /rest/v1/subscriptions/{subscriptionId}/customFields

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/subscriptions/88ace3ef-46e0-4019-bff9-51569c2acf99/customFields?customFieldList=b61ff3ea-62b7-4ffa-804d-bf3620bbbc1c'


Reponse Example

200 Deleted
```

DELETE /rest/v1/subscriptions/{subscriptionId}/customFields


### Description
구독에 커스텀 필드를 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**subscriptionId**  <br>*required*|string|
|**Query**|**customFieldList**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid subscription id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="createsubscriptiontags"></a>
## Add tags to subscription

```
POST /rest/v1/subscriptions/{subscriptionId}/tags

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/subscriptions/88ace3ef-46e0-4019-bff9-51569c2acf99/tags?tagList=00000000-0000-0000-0000-000000000001'


Reponse Example

201 Created
```

POST /rest/v1/subscriptions/{subscriptionId}/tags


### Description
구독에 태그를 추가하다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**subscriptionId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid subscription id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getsubscriptiontags"></a>
## Retrieve subscription tags

```
GET /rest/v1/subscriptions/{subscriptionId}/tags

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/subscriptions/88ace3ef-46e0-4019-bff9-51569c2acf99/tags?audit=NONE&includedDeleted=false'


Reponse Example

[
  {
    "tagId": "63f514c2-33e3-4306-b3c9-234c1ceb0833",
    "objectType": "SUBSCRIPTION",
    "objectId": "88ace3ef-46e0-4019-bff9-51569c2acf99",
    "tagDefinitionId": "00000000-0000-0000-0000-000000000001",
    "tagDefinitionName": "AUTO_PAY_OFF",
    "auditLogs": []
  }
]
```

GET /rest/v1/subscriptions/{subscriptionId}/tags


### Description
구독의 태그를 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**subscriptionId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**includedDeleted**  <br>*optional*|boolean|`"false"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [TagJson](#tagjson) > array|
|**400**|Invalid subscription id supplied|No Content|
|**404**|Subscription not found|No Content|


### Produces

* `application/json`


<a name="deletesubscriptiontags"></a>
## Remove tags from subscription

```
DELETE /rest/v1/subscriptions/{subscriptionId}/tags

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/subscriptions/88ace3ef-46e0-4019-bff9-51569c2acf99/tags?tagList=00000000-0000-0000-0000-000000000001'


Reponse Example

200 Deleted
```

DELETE /rest/v1/subscriptions/{subscriptionId}/tags


### Description
구독에 태그를 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**subscriptionId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid subscription id supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="uncancelentitlementplan"></a>
## Un-cancel an entitlement

```
PUT /rest/v1/subscriptions/{subscriptionId}/uncancel

Request Example

curl -X PUT 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/subscriptions/05ca1fd1-dbd2-4cf8-b9ac-16289dfe2d27/uncancel'


Reponse Example

200 OK
```

PUT /rest/v1/subscriptions/{subscriptionId}/uncancel


### Description
구독 중단(cancel) 요청 예약 상태일때, 예약일이 당도하지 않았다면, 구독 중단 예약을 취소할 수 있다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**subscriptionId**  <br>*required*|string|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid subscription id supplied|No Content|
|**404**|Entitlement not found|No Content|


### Produces

* `application/json`


<a name="tagdefinitions_resource"></a>
# TagDefinitions

<a name="createtagdefinition"></a>
## Create a tag definition

```
POST /rest/v1/tagDefinitions

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
    "name": "good_payment",
    "description": "Payment Successed."
  }' 
'http://localhost:18080/rest/v1/tagDefinitions'


Reponse Example

201 Created
```

POST /rest/v1/tagDefinitions


### Description
태그 정의를 추가한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Body**|**body**  <br>*optional*|[TagDefinitionJson](#tagdefinitionjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid name or description supplied|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="gettagdefinitions"></a>
## List tag definitions

```
GET /rest/v1/tagDefinitions

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/tagDefinitions?audit=NONE'


Reponse Example

[
  {
    "id": "00000000-0000-0000-0000-000000000001",
    "isControlTag": true,
    "name": "AUTO_PAY_OFF",
    "description": "Suspends payments until removed.",
    "applicableObjectTypes": [
      "ACCOUNT"
    ],
    "auditLogs": []
  },
  {
    "id": "00000000-0000-0000-0000-000000000002",
    "isControlTag": true,
    "name": "AUTO_INVOICING_OFF",
    "description": "Suspends invoicing until removed.",
    "applicableObjectTypes": [
      "ACCOUNT"
    ],
    "auditLogs": []
  },
  {
    "id": "00000000-0000-0000-0000-000000000003",
    "isControlTag": true,
    "name": "OVERDUE_ENFORCEMENT_OFF",
    "description": "Suspends overdue enforcement behaviour until removed.",
    "applicableObjectTypes": [
      "ACCOUNT"
    ],
    "auditLogs": []
  },
  {
    "id": "00000000-0000-0000-0000-000000000004",
    "isControlTag": true,
    "name": "WRITTEN_OFF",
    "description": "Indicates that an invoice is written off. No billing or payment effect.",
    "applicableObjectTypes": [
      "INVOICE"
    ],
    "auditLogs": []
  },
  {
    "id": "00000000-0000-0000-0000-000000000005",
    "isControlTag": true,
    "name": "MANUAL_PAY",
    "description": "Indicates that Killbill doesn't process payments for that account (external payments only)",
    "applicableObjectTypes": [
      "ACCOUNT"
    ],
    "auditLogs": []
  },
  {
    "id": "00000000-0000-0000-0000-000000000006",
    "isControlTag": true,
    "name": "TEST",
    "description": "Indicates that this is a test account",
    "applicableObjectTypes": [
      "ACCOUNT"
    ],
    "auditLogs": []
  },
  {
    "id": "00000000-0000-0000-0000-000000000007",
    "isControlTag": true,
    "name": "PARTNER",
    "description": "Indicates that this is a partner account",
    "applicableObjectTypes": [
      "ACCOUNT"
    ],
    "auditLogs": []
  }
]
```

GET /rest/v1/tagDefinitions


### Description
태그 정의 목록을 조회한다. 이 목록에는 빌링 시스템에서 쓰이는 필수 태그 및 사용자 정의 태그들이 포함된다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [TagDefinitionJson](#tagdefinitionjson) > array|


### Produces

* `application/json`


<a name="gettagdefinition"></a>
## Retrieve a tag definition

```
GET /rest/v1/tagDefinitions/{tagDefinitionId}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/tagDefinitions/00000000-0000-0000-0000-000000000001?audit=NONE'


Reponse Example

{
  "id": "00000000-0000-0000-0000-000000000001",
  "isControlTag": true,
  "name": "AUTO_PAY_OFF",
  "description": "Suspends payments until removed.",
  "applicableObjectTypes": [
    "ACCOUNT"
  ],
  "auditLogs": []
}
```

GET /rest/v1/tagDefinitions/{tagDefinitionId}


### Description
아이디로 태그 정의를 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**tagDefinitionId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TagDefinitionJson](#tagdefinitionjson)|
|**400**|Invalid tagDefinitionId supplied|No Content|


### Produces

* `application/json`


<a name="deletetagdefinition"></a>
## Delete a tag definition

```
DELETE /rest/v1/tagDefinitions/{tagDefinitionId}

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/tagDefinitions/ebd09193-c866-4c03-9881-eeffe58ec7fb'


Reponse Example

204 No content
```

DELETE /rest/v1/tagDefinitions/{tagDefinitionId}


### Description
태그 정의를 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**tagDefinitionId**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid tagDefinitionId supplied|No Content|


### Produces

* `application/json`


<a name="tags_resource"></a>
# Tags

<a name="gettags"></a>
## List tags

```
GET /rest/v1/tags/pagination

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/tags/pagination?offset=0&limit=100&audit=NONE'


Reponse Example

[
  {
    "tagId": "4266a72f-c45d-4fcb-bcdc-8389f86b863a",
    "objectType": "ACCOUNT",
    "objectId": "9b0d4b1e-36e8-4f31-94be-e61924f2667c",
    "tagDefinitionId": "00000000-0000-0000-0000-000000000002",
    "tagDefinitionName": "AUTO_INVOICING_OFF",
    "auditLogs": []
  },
  {
    "tagId": "4905725a-f758-4b9c-aa95-505a6319b60f",
    "objectType": "PAYMENT",
    "objectId": "32cd33b9-e763-4c30-a923-64276afbb839",
    "tagDefinitionId": "00000000-0000-0000-0000-000000000001",
    "tagDefinitionName": "AUTO_PAY_OFF",
    "auditLogs": []
  }
]
```

GET /rest/v1/tags/pagination


### Description
태그를 페이징하여 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [TagJson](#tagjson) > array|


### Produces

* `application/json`


<a name="searchtags"></a>
## Search tags

```
GET /rest/v1/tags/search/{searchKey}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/tags/search/ACCOUNT?offset=0&limit=100&audit=NONE'



Reponse Example

[
  {
    "tagId": "4266a72f-c45d-4fcb-bcdc-8389f86b863a",
    "objectType": "ACCOUNT",
    "objectId": "9b0d4b1e-36e8-4f31-94be-e61924f2667c",
    "tagDefinitionId": "00000000-0000-0000-0000-000000000002",
    "tagDefinitionName": "AUTO_INVOICING_OFF",
    "auditLogs": []
  }
]
```

GET /rest/v1/tags/search/{searchKey}


### Description
주어진 검색어로 태그를 페이징 하여 조회한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**searchKey**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [TagJson](#tagjson) > array|


### Produces

* `application/json`


<a name="template_resource"></a>
# Template

<a name="getalltemplates"></a>
## List notification templates

```
GET /rest/v1/template

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/template'


Reponse Example

{
  "FAILED_PAYMENT": [
    {
      "record_id": 11,
      "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
      "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
      "tenant_record_id": 29,
      "notification_type": "FAILED_PAYMENT",
      "locale": "en_US",
      "is_default": "Y",
      "subject": "Failed Payment from {{organization.company_name}}",
      "body": "<div>Oops, your most recent subscription payment was declined by your bank.</div>\n<div><br></div>\n<div>Here are the details of your declined payment:</div>\n<div><br></div>\n<div>invoiceNumber: {{invoice.invoiceNumber}}</div>\n<div>paymentDate: {{invoice.invoiceDate}}</div>\n<div><br></div>\n<div>{{#invoice.invoiceItems}}</div>\n<div>{{startDate}} {{planName}} : {{formattedAmount}}</div>\n<div>{{/invoice.invoiceItems}}</div>\n<div><br></div>\n<div>invoiceAmountPaid: &nbsp;{{invoice.formattedPaidAmount}}</div>\n<div>invoiceAmountTotal: {{invoice.formattedBalance}}</div>\n<div><br></div>\n<div><br></div>\n<div>billedTo:</div>\n<div>{{account.companyName}}</div>\n<div>{{account.name}}</div>\n<div>{{account.address1}}</div>\n<div>{{account.city}}, {{account.stateOrProvince}} {{account.postalCode}}</div>\n<div>{{account.country}}</div>\n<div><br></div>\n<div>You can update your payment information here:</div>\n<div>http://your-application/payment-method-update-page</div>\n<div><br></div>\n<div>To ensure continued access to {{organization.company_name}}, please update your billing information within 14 days\n    of your last statement.\n</div>\n<div><br></div>\n<div>If you have any questions about your account, please reply to this email or contact {{organization.company_name}}\n    Support at: {{organization.phone}}\n</div>",
      "reg_dt": "2017-03-16"
    }
  ],
  "PAYMENT_REFUND": [
    {
      "record_id": 14,
      "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
      "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
      "tenant_record_id": 29,
      "notification_type": "PAYMENT_REFUND",
      "locale": "en_US",
      "is_default": "Y",
      "subject": "Refund Receipt from {{organization.company_name}}",
      "body": "<div>*** Your payment has been refunded ***</div><div><br></div><div>We have processed a refund in the amount of {{payment.formattedAmount}}.</div><div><br></div><div>This refund will appear on your next credit card statement in approximately 3-5 business days.</div><div><br></div><div>If you have any questions about your account, please reply to this email or contact {{organization.company_name}} Support at: {{organization.phone}}</div>",
      "reg_dt": "2017-03-16"
    }
  ],
  "SUBSCRIPTION_CANCELLATION_REQUESTED": [
    {
      "record_id": 12,
      "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
      "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
      "tenant_record_id": 29,
      "notification_type": "SUBSCRIPTION_CANCELLATION_REQUESTED",
      "locale": "en_US",
      "is_default": "Y",
      "subject": "Subscription Ended from {{organization.company_name}}",
      "body": "<div>This email is to confirm your recent subscription cancellation. Your subscription will remain active until {{subscription.chargedThroughDate}}.</div><div><br></div><div>Here are the details of the subscription you canceled:</div><div><br></div><div>Description: {{subscription.lastActivePlan.name}}</div><div>Expires at: &nbsp;{{subscription.chargedThroughDate}}</div><div><br></div><div>At the end of your subscription, your {{organization.company_name}} account will be disabled and you will not be able to access {{organization.company_name}} on your iPad.</div><div><br></div><div>We're sorry to see you go. &nbsp;If you have any questions or if you have received this message in error, please reply to this email or contact {{organization.company_name}} Support at {{organization.phone}}.</div><div><br></div><div>To reactivate your subscription before it expires, or to view previous invoices, please see your account at: http://your-application.com/invoice-page</div><div><br></div><div>If you have any questions about your account, please reply to this email or contact {{organization.company_name}} Support at: {{organization.phone}}</div>",
      "reg_dt": "2017-03-16"
    }
  ],
  "SUBSCRIPTION_CANCELLATION_EFFECTIVE": [
    {
      "record_id": 13,
      "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
      "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
      "tenant_record_id": 29,
      "notification_type": "SUBSCRIPTION_CANCELLATION_EFFECTIVE",
      "locale": "en_US",
      "is_default": "Y",
      "subject": "Subscription Canceled from {{organization.company_name}}",
      "body": "<div>Your Personal subscription to {{organization.company_name}} was canceled earlier and has now ended.</div><div><br></div><div>Your access to {{organization.company_name}} on your iPad will end shortly.</div><div><br></div><div>We're sorry to see you go. &nbsp;To reactivate your {{organization.company_name}} service, contact the Support Team at {{organization.phone}}</div><div><br></div><div>If you have any questions about your account, please reply to this email or contact {{organization.company_name}} Support at: {{organization.phone}}</div>",
      "reg_dt": "2017-03-16"
    }
  ],
  "SUCCESSFUL_PAYMENT": [
    {
      "record_id": 10,
      "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
      "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
      "tenant_record_id": 29,
      "notification_type": "SUCCESSFUL_PAYMENT",
      "locale": "en_US",
      "is_default": "Y",
      "subject": "Payment Confirmation from {{organization.company_name}}",
      "body": "<div>This email confirms your recent payment.</div><div><br></div><div>Here are the details of your payment:</div><div><br></div><div>invoiceNumber: {{invoice.invoiceNumber}}</div><div>paymentDate: {{invoice.invoiceDate}}</div><div><br></div><div>{{#invoice.invoiceItems}}</div><div>{{startDate}} {{planName}} : {{formattedAmount}}</div><div>{{/invoice.invoiceItems}}</div><div><br></div><div>invoiceAmountPaid: &nbsp;{{invoice.formattedPaidAmount}}</div><div>invoiceAmountTotal: {{invoice.formattedBalance}}</div><div><br></div><div>billedTo:</div><div>{{account.companyName}}</div><div>{{account.name}}</div><div>{{account.address1}}</div><div>{{account.city}}, {{account.stateOrProvince}} {{account.postalCode}}</div><div>{{account.country}}</div><div><br></div><div>If you have any questions about your account, please reply to this email or contact {{organization.company_name}} Support at: {{organization.phone}}</div>",
      "reg_dt": "2017-03-16"
    },
    {
      "record_id": 16,
      "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
      "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
      "tenant_record_id": 29,
      "notification_type": "SUCCESSFUL_PAYMENT",
      "locale": "ko_KR",
      "is_default": "N",
      "subject": "한국 인보이스",
      "body": "<p>결제 성공</p><p><br></p><p>{{organization.company_name}} 성공 이메일</p>",
      "reg_dt": "2017-03-17"
    }
  ],
  "INVOICE": [
    {
      "record_id": 9,
      "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
      "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
      "tenant_record_id": 29,
      "notification_type": "INVOICE",
      "locale": "en_US",
      "is_default": "Y",
      "subject": "Invoice from {{organization.company_name}} (Invoice#: {{invoice.invoiceNumber}})",
      "body": "<html>\n<head>\n    <style type=\"text/css\">\n        th {\n            text-align: left;\n            width: 225px;\n            border-bottom: solid 2px black;\n        }\n    </style>\n</head>\n<body>\n<h1>invoiceTitle</h1>\n<table>\n    <tr>\n        <td rowspan=3 width=350px>Insert image here</td>\n        <td width=100px/>\n        <td width=225px/>\n        <td width=225px/>\n    </tr>\n    <tr>\n        <td/>\n        <td align=right>invoiceDate</td>\n        <td>{{invoice.formattedInvoiceDate}}</td>\n    </tr>\n    <tr>\n        <td/>\n        <td align=right>invoiceNumber</td>\n        <td>{{invoice.invoiceNumber}}</td>\n    </tr>\n    <tr>\n        <td>companyName</td>\n        <td></td>\n        <td align=right>accountOwnerName</td>\n        <td>{{account.name}}</td>\n    </tr>\n    <tr>\n        <td>companyAddress</td>\n        <td/>\n        <td/>\n        <td>{{account.email}}</td>\n    </tr>\n    <tr>\n        <td>companyCityProvincePostalCode</td>\n        <td/>\n        <td/>\n        <td>{{account.phone}}</td>\n    </tr>\n    <tr>\n        <td>companyCountry</td>\n        <td/>\n        <td/>\n        <td/>\n    </tr>\n</table>\n<br/>\n<br/>\n<br/>\n<table>\n    <tr>\n        <th>Description\n        </td>\n        <th>BundleName\n        </td>\n        <th>ServicePeriod\n        </td>\n        <th>Amount\n        </td>\n    </tr>\n    {{#invoice.invoiceItems}}\n    <tr>\n        <td>{{description}}</td>\n        <td>{{planName}}</td>\n        <td>{{formattedStartDate}}{{#formattedEndDate}} - {{formattedEndDate}}{{/formattedEndDate}}</td>\n        <td>{{invoice.currency}} {{amount}}</td>\n    </tr>\n    {{/invoice.invoiceItems}}\n    <tr>\n        <td colspan=4/>\n    </tr>\n    <tr>\n        <td colspan=2/>\n        <td align=right><strong>invoiceAmount</strong></td>\n        <td align=right><strong>{{invoice.chargedAmount}}</strong></td>\n    </tr>\n    <tr>\n        <td colspan=2/>\n        <td align=right><strong>invoiceAmountPaid</strong></td>\n        <td align=right><strong>{{invoice.paidAmount}}</strong></td>\n    </tr>\n    <tr>\n        <td colspan=2/>\n        <td align=right><strong>invoiceBalance</strong></td>\n        <td align=right><strong>{{invoice.balance}}</strong></td>\n    </tr>\n</table>\n</body>\n</html>",
      "reg_dt": "2017-03-16"
    },
    {
      "record_id": 17,
      "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
      "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
      "tenant_record_id": 29,
      "notification_type": "INVOICE",
      "locale": "ko_KR",
      "is_default": "N",
      "subject": "인보이스입니다.",
      "body": "<html>\n<head>\n    <style type=\"text/css\">\n        th {\n            text-align: left;\n            width: 225px;\n            border-bottom: solid 2px black;\n        }\n    </style>\n</head>\n<body>\n<h1>invoiceTitle</h1>\n<table>\n    <tr>\n        <td rowspan=3 width=350px>Insert image here</td>\n        <td width=100px/>\n        <td width=225px/>\n        <td width=225px/>\n    </tr>\n    <tr>\n        <td/>\n        <td align=right>invoiceDate</td>\n        <td>{{invoice.formattedInvoiceDate}}</td>\n    </tr>\n    <tr>\n        <td/>\n        <td align=right>invoiceNumber</td>\n        <td>{{invoice.invoiceNumber}}</td>\n    </tr>\n    <tr>\n        <td>companyName</td>\n        <td></td>\n        <td align=right>accountOwnerName</td>\n        <td>{{account.name}}</td>\n    </tr>\n    <tr>\n        <td>companyAddress</td>\n        <td/>\n        <td/>\n        <td>{{account.email}}</td>\n    </tr>\n    <tr>\n        <td>companyCityProvincePostalCode</td>\n        <td/>\n        <td/>\n        <td>{{account.phone}}</td>\n    </tr>\n    <tr>\n        <td>companyCountry</td>\n        <td/>\n        <td/>\n        <td/>\n    </tr>\n</table>\n<br/>\n<br/>\n<br/>\n<table>\n    <tr>\n        <th>Description\n        </td>\n        <th>BundleName\n        </td>\n        <th>ServicePeriod\n        </td>\n        <th>Amount\n        </td>\n    </tr>\n    {{#invoice.invoiceItems}}\n    <tr>\n        <td>{{description}}</td>\n        <td>{{planName}}</td>\n        <td>{{formattedStartDate}}{{#formattedEndDate}} - {{formattedEndDate}}{{/formattedEndDate}}</td>\n        <td>{{invoice.currency}} {{amount}}</td>\n    </tr>\n    {{/invoice.invoiceItems}}\n    <tr>\n        <td colspan=4/>\n    </tr>\n    <tr>\n        <td colspan=2/>\n        <td align=right><strong>invoiceAmount</strong></td>\n        <td align=right><strong>{{invoice.chargedAmount}}</strong></td>\n    </tr>\n    <tr>\n        <td colspan=2/>\n        <td align=right><strong>invoiceAmountPaid</strong></td>\n        <td align=right><strong>{{invoice.paidAmount}}</strong></td>\n    </tr>\n    <tr>\n        <td colspan=2/>\n        <td align=right><strong>invoiceBalance</strong></td>\n        <td align=right><strong>{{invoice.balance}}</strong></td>\n    </tr>\n</table>\n</body>\n</html>",
      "reg_dt": "2017-03-21"
    }
  ]
}
```

GET /rest/v1/template


### Description
Notification template 목록을 조회한다.


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TemplatePerNotificationJson](#templatepernotificationjson)|
|**400**|Invalid Request|No Content|


### Produces

* `application/json`


<a name="gettemplatebytype"></a>
## Retrieve an template by notificationType

```
GET /rest/v1/template/{notificationType}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/template/SUCCESSFUL_PAYMENT'


Reponse Example

{
  "SUCCESSFUL_PAYMENT": [
    {
      "record_id": 10,
      "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
      "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
      "tenant_record_id": 29,
      "notification_type": "SUCCESSFUL_PAYMENT",
      "locale": "en_US",
      "is_default": "Y",
      "subject": "Payment Confirmation from {{organization.company_name}}",
      "body": "<div>This email confirms your recent payment.</div><div><br></div><div>Here are the details of your payment:</div><div><br></div><div>invoiceNumber: {{invoice.invoiceNumber}}</div><div>paymentDate: {{invoice.invoiceDate}}</div><div><br></div><div>{{#invoice.invoiceItems}}</div><div>{{startDate}} {{planName}} : {{formattedAmount}}</div><div>{{/invoice.invoiceItems}}</div><div><br></div><div>invoiceAmountPaid: &nbsp;{{invoice.formattedPaidAmount}}</div><div>invoiceAmountTotal: {{invoice.formattedBalance}}</div><div><br></div><div>billedTo:</div><div>{{account.companyName}}</div><div>{{account.name}}</div><div>{{account.address1}}</div><div>{{account.city}}, {{account.stateOrProvince}} {{account.postalCode}}</div><div>{{account.country}}</div><div><br></div><div>If you have any questions about your account, please reply to this email or contact {{organization.company_name}} Support at: {{organization.phone}}</div>",
      "reg_dt": "2017-03-16"
    },
    {
      "record_id": 16,
      "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
      "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
      "tenant_record_id": 29,
      "notification_type": "SUCCESSFUL_PAYMENT",
      "locale": "ko_KR",
      "is_default": "N",
      "subject": "한국 인보이스",
      "body": "<p>결제 성공</p><p><br></p><p>{{organization.company_name}} 성공 이메일</p>",
      "reg_dt": "2017-03-17"
    }
  ]
}
```

GET /rest/v1/template/{notificationType}


### Description
notificationType 별로 template 을 조회한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**notificationType**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TemplatePerNotificationJson](#templatepernotificationjson)|
|**400**|Invalid notificationType supplied|No Content|


### Produces

* `application/json`


<a name="deletetemplatebytype"></a>
## Remove template by notificationType

```
DELETE /rest/v1/template/{notificationType}

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/template/SUCCESSFUL_PAYMENT'



Reponse Example

204 No Content
```

DELETE /rest/v1/template/{notificationType}


### Description
notificationType 의 template 을 모두 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**notificationType**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|successful operation|No Content|
|**400**|Invalid notificationType supplied|No Content|


### Produces

* `application/json`


<a name="createtemplate"></a>
## Upload template by notificationType and locale

```
POST /rest/v1/template/{notificationType}/{locale}

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
      "record_id": 18,
      "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
      "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
      "tenant_record_id": 29,
      "notification_type": "SUCCESSFUL_PAYMENT",
      "locale": "en_US",
      "is_default": "Y",
      "subject": "Payment Confirmation from {{organization.company_name}}",
      "body": "<div>This email confirms your recent payment.</div>\n<div><br></div>\n<div>Here are the details of your payment:</div>\n<div><br></div>\n<div>invoiceNumber: {{invoice.invoiceNumber}}</div>\n<div>paymentDate: {{invoice.invoiceDate}}</div>\n<div><br></div>\n<div>{{#invoice.invoiceItems}}</div>\n<div>{{startDate}} {{planName}} : {{formattedAmount}}</div>\n<div>{{/invoice.invoiceItems}}</div>\n<div><br></div>\n<div>invoiceAmountPaid: &nbsp;{{invoice.formattedPaidAmount}}</div>\n<div>invoiceAmountTotal: {{invoice.formattedBalance}}</div>\n<div><br></div>\n<div>billedTo:</div>\n<div>{{account.companyName}}</div>\n<div>{{account.name}}</div>\n<div>{{account.address1}}</div>\n<div>{{account.city}}, {{account.stateOrProvince}} {{account.postalCode}}</div>\n<div>{{account.country}}</div>\n<div><br></div>\n<div>If you have any questions about your account, please reply to this email or contact {{organization.company_name}}\n    Support at: {{organization.phone}}\n</div>",
      "reg_dt": "2017-03-26"
    }' 
'http://localhost:18080/rest/v1/template/SUCCESSFUL_PAYMENT/en_US'


Reponse Example

201 Created
```

POST /rest/v1/template/{notificationType}/{locale}


### Description
notificationType 과 locale 에 해당하는 template 을 업로드한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**locale**  <br>*required*|string|
|**Path**|**notificationType**  <br>*required*|string|
|**Body**|**body**  <br>*required*|[TemplateJson](#templatejson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|successful operation|No Content|
|**400**|Invalid Request|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="gettemplatebytypeandlocale"></a>
## Retrieve an template by notificationType and locale

```
GET /rest/v1/template/{notificationType}/{locale}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/template/SUCCESSFUL_PAYMENT/en_US'


Reponse Example

{
  "record_id": 18,
  "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
  "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
  "tenant_record_id": 29,
  "notification_type": "SUCCESSFUL_PAYMENT",
  "locale": "en_US",
  "is_default": "Y",
  "subject": "Payment Confirmation from {{organization.company_name}}",
  "body": "<div>This email confirms your recent payment.</div>\n<div><br></div>\n<div>Here are the details of your payment:</div>\n<div><br></div>\n<div>invoiceNumber: {{invoice.invoiceNumber}}</div>\n<div>paymentDate: {{invoice.invoiceDate}}</div>\n<div><br></div>\n<div>{{#invoice.invoiceItems}}</div>\n<div>{{startDate}} {{planName}} : {{formattedAmount}}</div>\n<div>{{/invoice.invoiceItems}}</div>\n<div><br></div>\n<div>invoiceAmountPaid: &nbsp;{{invoice.formattedPaidAmount}}</div>\n<div>invoiceAmountTotal: {{invoice.formattedBalance}}</div>\n<div><br></div>\n<div>billedTo:</div>\n<div>{{account.companyName}}</div>\n<div>{{account.name}}</div>\n<div>{{account.address1}}</div>\n<div>{{account.city}}, {{account.stateOrProvince}} {{account.postalCode}}</div>\n<div>{{account.country}}</div>\n<div><br></div>\n<div>If you have any questions about your account, please reply to this email or contact {{organization.company_name}}\n    Support at: {{organization.phone}}\n</div>",
  "reg_dt": "2017-03-26"
}
```

GET /rest/v1/template/{notificationType}/{locale}


### Description
notificationType 과 locale 에 해당하는 template 을 조회한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**locale**  <br>*required*|string|
|**Path**|**notificationType**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TemplateJson](#templatejson)|
|**400**|Invalid notificationType and locale supplied|No Content|
|**404**|template not found|No Content|


### Produces

* `application/json`


<a name="setdefaulttemplate"></a>
## Set default template by notificationType and locale

```
PUT /rest/v1/template/{notificationType}/{locale}

Request Example

curl -X PUT 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/template/SUCCESSFUL_PAYMENT/en_US'


Reponse Example

{
  "record_id": 18,
  "organization_id": "c16ba270-2842-4339-ac35-91c225eaf185",
  "tenant_id": "5da34e77-c429-46f3-8678-e2c638455df4",
  "tenant_record_id": 29,
  "notification_type": "SUCCESSFUL_PAYMENT",
  "locale": "en_US",
  "is_default": "Y",
  "subject": "Payment Confirmation from {{organization.company_name}}",
  "body": "<div>This email confirms your recent payment.</div>\n<div><br></div>\n<div>Here are the details of your payment:</div>\n<div><br></div>\n<div>invoiceNumber: {{invoice.invoiceNumber}}</div>\n<div>paymentDate: {{invoice.invoiceDate}}</div>\n<div><br></div>\n<div>{{#invoice.invoiceItems}}</div>\n<div>{{startDate}} {{planName}} : {{formattedAmount}}</div>\n<div>{{/invoice.invoiceItems}}</div>\n<div><br></div>\n<div>invoiceAmountPaid: &nbsp;{{invoice.formattedPaidAmount}}</div>\n<div>invoiceAmountTotal: {{invoice.formattedBalance}}</div>\n<div><br></div>\n<div>billedTo:</div>\n<div>{{account.companyName}}</div>\n<div>{{account.name}}</div>\n<div>{{account.address1}}</div>\n<div>{{account.city}}, {{account.stateOrProvince}} {{account.postalCode}}</div>\n<div>{{account.country}}</div>\n<div><br></div>\n<div>If you have any questions about your account, please reply to this email or contact {{organization.company_name}}\n    Support at: {{organization.phone}}\n</div>",
  "reg_dt": "2017-03-26"
}
```

PUT /rest/v1/template/{notificationType}/{locale}


### Description
notificationType 과 locale 에 해당하는 template 을 default template 으로 지정한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**locale**  <br>*required*|string|
|**Path**|**notificationType**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TemplateJson](#templatejson)|
|**400**|Invalid notificationType and locale supplied|No Content|
|**404**|template not found|No Content|


### Produces

* `application/json`


<a name="deletetemplatebytypeandlocale"></a>
## Remove template by notificationType and locale

```
DELETE /rest/v1/template/{notificationType}/{locale}

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/template/INVOICE/ko_KR'


Reponse Example

204 No content
```

DELETE /rest/v1/template/{notificationType}/{locale}


### Description
notificationType 과 locale 에 해당하는 template 을 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**locale**  <br>*required*|string|
|**Path**|**notificationType**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|successful operation|No Content|
|**400**|Invalid notificationType and locale supplied|No Content|
|**404**|template not found|No Content|


### Produces

* `application/json`


<a name="tenants_resource"></a>
# Tenants

<a name="gettenantbyapikey"></a>
## Retrieve a tenant by its API key

```
GET /rest/v1/tenants

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
'http://localhost:18080/rest/v1/tenants?apiKey=376af2e2-f618-4935-a3a6-99e2dd4003f3'


Reponse Example

{
  "tenantId": "5da34e77-c429-46f3-8678-e2c638455df4",
  "externalKey": "376af2e2-f618-4935-a3a6-99e2dd4003f3",
  "apiKey": "376af2e2-f618-4935-a3a6-99e2dd4003f3",
  "apiSecret": null,
  "auditLogs": null
}
```

GET /rest/v1/tenants


### Description
api key 로 테넌트를 조회한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Query**|**apiKey**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TenantJson](#tenantjson)|
|**404**|Tenant not found|No Content|


### Produces

* `application/json`


<a name="uploadpertenantconfiguration"></a>
## Add a per tenant configuration (system properties)

```
POST /rest/v1/tenants/uploadPerTenantConfig

Request Example

curl -X POST 
--header 'Content-Type: text/plain' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{"org.killbill.payment.retry.days":"1,1,1"}' 
'http://localhost:18080/rest/v1/tenants/uploadPerTenantConfig'


Reponse Example

201 Created
```

POST /rest/v1/tenants/uploadPerTenantConfig


### Description
테넌트 고유 시스템 프로퍼티를 추가한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Body**|**body**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid tenantId supplied|No Content|


### Consumes

* `text/plain`


### Produces

* `application/json`


<a name="getpertenantconfiguration"></a>
## Retrieve a per tenant configuration (system properties)

```
GET /rest/v1/tenants/uploadPerTenantConfig

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/tenants/uploadPerTenantConfig'


Reponse Example

{
  "key": "PER_TENANT_CONFIG",
  "values": [
    "{\"org.killbill.payment.retry.days\":\"1,1,1\"}"
  ]
}
```

GET /rest/v1/tenants/uploadPerTenantConfig


### Description
테넌트 고유 시스템 프로퍼티를 조회한다.


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TenantKeyJson](#tenantkeyjson)|
|**400**|Invalid tenantId supplied|No Content|


### Produces

* `application/json`


<a name="deletepertenantconfiguration"></a>
## Delete a per tenant configuration (system properties)

```
DELETE /rest/v1/tenants/uploadPerTenantConfig

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/tenants/uploadPerTenantConfig'


Reponse Example

200 Deleted
```

DELETE /rest/v1/tenants/uploadPerTenantConfig


### Description
테넌트 고유 시스템 프로퍼티를 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid tenantId supplied|No Content|


<a name="getallpluginconfiguration"></a>
## Retrieve a per tenant key value based on key prefix

```
GET /rest/v1/tenants/uploadPerTenantConfig/{keyPrefix}/search

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/tenants/uploadPerTenantConfig/PER_TENANT_CONFIG/search'


Reponse Example

[
  {
    "key": "PER_TENANT_CONFIG",
    "values": [
      "{\"org.killbill.payment.retry.days\":\"1,1,1\"}"
    ]
  }
]
```

GET /rest/v1/tenants/uploadPerTenantConfig/{keyPrefix}/search


### Description
주어진 프로퍼티 키에 해당하는 테넌트 고유 시스템 프로퍼티를 조회한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**keyPrefix**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TenantKeyJson](#tenantkeyjson)|
|**400**|Invalid tenantId supplied|No Content|


### Produces

* `application/json`


<a name="uploadpluginconfiguration"></a>
## Add a per tenant configuration for a plugin

```
POST /rest/v1/tenants/uploadPluginConfig/{pluginName}

Request Example

curl -X POST 
--header 'Content-Type: text/plain' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d ':paypal_express:
  :signature: "AFcWxV21C7fd0v3bYYYRCpSSRl31AMcE0Wek0G6Vp-SmFlXQb7CW1xmT"
  :login: "darkgodarkgo-facilitator_api1.gmail.com"
  :password: "KDAVR7W8W28AXL4F"' 
'http://localhost:18080/rest/v1/tenants/uploadPluginConfig/killbill-paypal-express'


Reponse Example

201 Created
```

POST /rest/v1/tenants/uploadPluginConfig/{pluginName}


### Description
테넌트 플러그인 설정값을 추가한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**pluginName**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid tenantId supplied|No Content|


### Consumes

* `text/plain`


### Produces

* `application/json`


<a name="getpluginconfiguration"></a>
## Retrieve a per tenant configuration for a plugin

```
GET /rest/v1/tenants/uploadPluginConfig/{pluginName}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/tenants/uploadPluginConfig/killbill-paypal-express'


Reponse Example

{
  "key": "PLUGIN_CONFIG_killbill-paypal-express",
  "values": [
    ":paypal_express:\n  :signature: \"AFcWxV21C7fd0v3bYYYRCpSSRl31AMcE0Wek0G6Vp-SmFlXQb7CW1xmT\"\n  :login: \"darkgodarkgo-facilitator_api1.gmail.com\"\n  :password: \"KDAVR7W8W28AXL4F\""
  ]
}
```

GET /rest/v1/tenants/uploadPluginConfig/{pluginName}


### Description
테넌트 플러그인 설정값을 조회한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**pluginName**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TenantKeyJson](#tenantkeyjson)|
|**400**|Invalid tenantId supplied|No Content|


### Produces

* `application/json`


<a name="deletepluginconfiguration"></a>
## Delete a per tenant configuration for a plugin

```
DELETE /rest/v1/tenants/uploadPluginConfig/{pluginName}

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/tenants/uploadPluginConfig/killbill-paypal-express'


Reponse Example

200 Deleted
```

DELETE /rest/v1/tenants/uploadPluginConfig/{pluginName}


### Description
테넌트 플러그인 설정값을 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**pluginName**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid tenantId supplied|No Content|


<a name="insertuserkeyvalue"></a>
## Add a per tenant user key/value

```
POST /rest/v1/tenants/userKeyValue/{keyName}

Request Example

curl -X POST 
--header 'Content-Type: text/plain' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d 'Custom Content Text Value for tenant' 
'http://localhost:18080/rest/v1/tenants/userKeyValue/CUSTOMKEY'


Reponse Example

201 Created
```

POST /rest/v1/tenants/userKeyValue/{keyName}


### Description
테넌트의 사용자 key value 를 추가한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**keyName**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid tenantId supplied|No Content|


### Consumes

* `text/plain`


### Produces

* `application/json`


<a name="getuserkeyvalue"></a>
## Retrieve a per tenant user key/value

```
GET /rest/v1/tenants/userKeyValue/{keyName}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/tenants/userKeyValue/CUSTOMKEY'


Reponse Example

{
  "key": "CUSTOMKEY",
  "values": [
    "Custom Content Text Value for tenant"
  ]
}
```

GET /rest/v1/tenants/userKeyValue/{keyName}


### Description
테넌트의 사용자 key value 를 조회한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**keyName**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TenantKeyJson](#tenantkeyjson)|
|**400**|Invalid tenantId supplied|No Content|


### Produces

* `application/json`


<a name="deleteuserkeyvalue"></a>
## Delete  a per tenant user key/value

```
DELETE /rest/v1/tenants/userKeyValue/{keyName}

Request Example

curl -X DELETE 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/tenants/userKeyValue/CUSTOMKEY'


Reponse Example

200 Deleted
```

DELETE /rest/v1/tenants/userKeyValue/{keyName}


### Description
테넌트의 사용자 key value 를 삭제한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**keyName**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid tenantId supplied|No Content|


<a name="gettenant"></a>
## Retrieve a tenant by id

```
GET /rest/v1/tenants/{tenantId}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/tenants/5da34e77-c429-46f3-8678-e2c638455df4'


Reponse Example

{
  "tenantId": "5da34e77-c429-46f3-8678-e2c638455df4",
  "externalKey": "376af2e2-f618-4935-a3a6-99e2dd4003f3",
  "apiKey": "376af2e2-f618-4935-a3a6-99e2dd4003f3",
  "apiSecret": null,
  "auditLogs": null
}
```

GET /rest/v1/tenants/{tenantId}


### Description
아이디로 테넌트를 조회한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**tenantId**  <br>*required*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TenantJson](#tenantjson)|
|**400**|Invalid tenantId supplied|No Content|
|**404**|Tenant not found|No Content|


### Produces

* `application/json`


<a name="test_resource"></a>
# Test

<a name="settestclocktime"></a>
## Set the current time

```
POST /rest/v1/test/clock

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/test/clock?requestedDate=2017-03-26&timeoutSec=5'



Reponse Example

200

{
  "currentUtcTime": "2017-03-26T00:00:05.000Z",
  "timeZone": "UTC",
  "localDate": "2017-03-26"
}
```

POST /rest/v1/test/clock


### Description
빌링 시스템의 현재 시각을 설정한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**requestedDate**  <br>*optional*|string||
|**Query**|**timeZone**  <br>*optional*|string||
|**Query**|**timeoutSec**  <br>*optional*|integer (int64)|`5`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[ClockResource](#clockresource)|
|**400**|Invalid time or timezone supplied|No Content|


### Produces

* `application/json`


<a name="getcurrenttime"></a>
## Get the current time

```
GET /rest/v1/test/clock

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/test/clock'


Reponse Example

{
  "currentUtcTime": "2017-03-26T03:11:08.000Z",
  "timeZone": "UTC",
  "localDate": "2017-03-26"
}
```

GET /rest/v1/test/clock


### Description
빌링 시스템의 현재 시각을 조회한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Query**|**timeZone**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[ClockResource](#clockresource)|
|**400**|Invalid timezone supplied|No Content|


### Produces

* `application/json`


<a name="updatetestclocktime"></a>
## Move the current time

```
PUT /rest/v1/test/clock

Request Example

curl -X PUT 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/test/clock?days=1&timeoutSec=5'



Reponse Example

200

{
  "currentUtcTime": "2017-03-27T00:00:24.000Z",
  "timeZone": "UTC",
  "localDate": "2017-03-27"
}
```

PUT /rest/v1/test/clock


### Description
빌링 시스템의 현재 시각을 주어진 값만큼 이동시킨다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**days**  <br>*optional*|integer (int32)||
|**Query**|**months**  <br>*optional*|integer (int32)||
|**Query**|**timeZone**  <br>*optional*|string||
|**Query**|**timeoutSec**  <br>*optional*|integer (int64)|`5`|
|**Query**|**weeks**  <br>*optional*|integer (int32)||
|**Query**|**years**  <br>*optional*|integer (int32)||


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[ClockResource](#clockresource)|
|**400**|Invalid timezone supplied|No Content|


### Produces

* `application/json`


<a name="waitforqueuestocomplete"></a>
## Wait for all available bus events and notifications to be processed

```
GET /rest/v1/test/queues

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/test/queues?timeoutSec=5'


Reponse Example

200 OK
```

GET /rest/v1/test/queues


### Description
빌링 시스템의 모든 큐 작업과 이메일 발송 작업이 끝날때까지 대기한다.


### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**timeoutSec**  <br>*optional*|integer (int64)|`5`|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**412**|Timeout too short|No Content|


<a name="usages_resource"></a>
# Usages

<a name="recordusage"></a>
## Record usage for a subscription

```
POST /rest/v1/usages

Request Example

curl -X POST 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'X-Killbill-CreatedBy: Swagger' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
-d '{
  "subscriptionId": "ef26383c-aed1-4c14-a7b1-e121d6457bda",
  "unitUsageRecords": [
    {
      "unitType": "storage",
      "usageRecords": [
        {
          "recordDate": "2017-03-29",
          "amount": 100
        }
      ]
    }
  ]
}' 
'http://localhost:18080/rest/v1/usages'


Reponse Example

201 Created
```

POST /rest/v1/usages


### Description
구독에 usage 사용량을 추가한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Body**|**body**  <br>*optional*|[SubscriptionUsageRecordJson](#subscriptionusagerecordjson)|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid subscription (e.g. inactive)|No Content|


### Consumes

* `application/json`


### Produces

* `application/json`


<a name="getallusage"></a>
## Retrieve usage for a subscription

```
GET /rest/v1/usages/{subscriptionId}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/usages/ef26383c-aed1-4c14-a7b1-e121d6457bda?startDate=2017-03-26&endDate=2017-04-25'


Reponse Example

{
  "subscriptionId": "ef26383c-aed1-4c14-a7b1-e121d6457bda",
  "startDate": "2017-03-26",
  "endDate": "2017-04-25",
  "rolledUpUnits": [
    {
      "unitType": "cpu",
      "amount": 12
    },
    {
      "unitType": "storage",
      "amount": 310
    }
  ]
}
```

GET /rest/v1/usages/{subscriptionId}


### Description
주어진 기간동안의 구독의 모든 usage 사용량을 조회한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**subscriptionId**  <br>*required*|string|
|**Query**|**endDate**  <br>*optional*|string|
|**Query**|**startDate**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[RolledUpUsageJson](#rolledupusagejson)|
|**400**|Missing start date or end date|No Content|


### Produces

* `application/json`


<a name="getusage"></a>
## Retrieve usage for a subscription and unit type

```
GET /rest/v1/usages/{subscriptionId}/{unitType}

Request Example

curl -X GET 
--header 'Accept: application/json' 
--header 'Authorization: <token>' 
--header 'X-organization-id: c16ba270-2842-4339-ac35-91c225eaf185' 
'http://localhost:18080/rest/v1/usages/ef26383c-aed1-4c14-a7b1-e121d6457bda/storage?startDate=2017-03-26&endDate=2017-04-25'


Reponse Example

{
  "subscriptionId": "ef26383c-aed1-4c14-a7b1-e121d6457bda",
  "startDate": "2017-03-26",
  "endDate": "2017-04-25",
  "rolledUpUnits": [
    {
      "unitType": "storage",
      "amount": 310
    }
  ]
}
```

GET /rest/v1/usages/{subscriptionId}/{unitType}


### Description
주어진 unit 과 주어진 기간동안의 구독의 usage 사용량을 조회한다.


### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**subscriptionId**  <br>*required*|string|
|**Path**|**unitType**  <br>*required*|string|
|**Query**|**endDate**  <br>*optional*|string|
|**Query**|**startDate**  <br>*optional*|string|


### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[RolledUpUsageJson](#rolledupusagejson)|
|**400**|Missing start date or end date|No Content|


### Produces

* `application/json`




<a name="definitions"></a>
# Definitions

<a name="accountemailjson"></a>
## AccountEmailJson

|Name|Schema|
|---|---|
|**accountId**  <br>*optional*|string (uuid)|
|**auditLogs**  <br>*optional*|< [AuditLogJson](#auditlogjson) > array|
|**email**  <br>*required*|string|


<a name="accountjson"></a>
## AccountJson

|Name|Description|Schema|
|---|---|---|
|**accountBalance**  <br>*optional*||number|
|**accountCBA**  <br>*optional*||number|
|**accountId**  <br>*optional*||string (uuid)|
|**address1**  <br>*optional*||string|
|**address2**  <br>*optional*||string|
|**auditLogs**  <br>*optional*||< [AuditLogJson](#auditlogjson) > array|
|**billCycleDayLocal**  <br>*optional*||integer (int32)|
|**city**  <br>*optional*||string|
|**company**  <br>*optional*||string|
|**country**  <br>*optional*||string|
|**currency**  <br>*optional*||string|
|**email**  <br>*optional*||string|
|**externalKey**  <br>*optional*||string|
|**firstNameLength**  <br>*optional*||integer (int32)|
|**isMigrated**  <br>*optional*|**Default** : `false`|boolean|
|**isNotifiedForInvoices**  <br>*optional*|**Default** : `false`|boolean|
|**isPaymentDelegatedToParent**  <br>*optional*|**Default** : `false`|boolean|
|**locale**  <br>*optional*||string|
|**name**  <br>*optional*||string|
|**notes**  <br>*optional*||string|
|**parentAccountId**  <br>*optional*||string (uuid)|
|**paymentMethodId**  <br>*optional*||string (uuid)|
|**phone**  <br>*optional*||string|
|**postalCode**  <br>*optional*||string|
|**state**  <br>*optional*||string|
|**timeZone**  <br>*optional*||string|


<a name="accounttimelinejson"></a>
## AccountTimelineJson

|Name|Schema|
|---|---|
|**account**  <br>*optional*|[AccountJson](#accountjson)|
|**bundles**  <br>*optional*|< [BundleJson](#bundlejson) > array|
|**invoices**  <br>*optional*|< [InvoiceJson](#invoicejson) > array|
|**payments**  <br>*optional*|< [InvoicePaymentJson](#invoicepaymentjson) > array|


<a name="auditlogjson"></a>
## AuditLogJson

|Name|Schema|
|---|---|
|**changeDate**  <br>*optional*|string (date-time)|
|**changeType**  <br>*optional*|string|
|**changedBy**  <br>*optional*|string|
|**comments**  <br>*optional*|string|
|**reasonCode**  <br>*optional*|string|
|**userToken**  <br>*optional*|string|


<a name="billingrulejson"></a>
## BillingRuleJson

|Name|Schema|
|---|---|
|**billingAlignment**  <br>*optional*|< [billingAlignmentJson](#billingalignmentjson) > array|
|**cancelPolicy**  <br>*optional*|< [cancelPolicyJson](#cancelpolicyjson) > array|
|**changeAlignment**  <br>*optional*|< [changeAlignmentJson](#changealignmentjson) > array|
|**changePolicy**  <br>*optional*|< [changePolicyJson](#changepolicyjson) > array|
|**createAlignment**  <br>*optional*|< [createAlignmentJson](#createalignmentjson) > array|
|**recurringBillingMode**  <br>*optional*|enum (IN_ADVANCE, IN_ARREAR)|


<a name="blockingstatejson"></a>
## BlockingStateJson

|Name|Description|Schema|
|---|---|---|
|**auditLogs**  <br>*optional*||< [AuditLogJson](#auditlogjson) > array|
|**blockBilling**  <br>*optional*|**Default** : `false`|boolean|
|**blockChange**  <br>*optional*|**Default** : `false`|boolean|
|**blockEntitlement**  <br>*optional*|**Default** : `false`|boolean|
|**blockedId**  <br>*optional*||string (uuid)|
|**effectiveDate**  <br>*optional*||string (date-time)|
|**service**  <br>*optional*||string|
|**stateName**  <br>*optional*||string|
|**type**  <br>*optional*||enum (SUBSCRIPTION, SUBSCRIPTION_BUNDLE, ACCOUNT)|


<a name="bulkbasesubscriptionandaddonsjson"></a>
## BulkBaseSubscriptionAndAddOnsJson

|Name|Schema|
|---|---|
|**baseEntitlementAndAddOns**  <br>*required*|< [SubscriptionJson](#subscriptionjson) > array|


<a name="bundlejson"></a>
## BundleJson

|Name|Schema|
|---|---|
|**accountId**  <br>*required*|string (uuid)|
|**auditLogs**  <br>*optional*|< [AuditLogJson](#auditlogjson) > array|
|**bundleId**  <br>*optional*|string (uuid)|
|**externalKey**  <br>*optional*|string|
|**subscriptions**  <br>*optional*|< [SubscriptionJson](#subscriptionjson) > array|
|**timeline**  <br>*optional*|[BundleTimelineJson](#bundletimelinejson)|


<a name="bundletimelinejson"></a>
## BundleTimelineJson

|Name|Schema|
|---|---|
|**accountId**  <br>*optional*|string (uuid)|
|**auditLogs**  <br>*optional*|< [AuditLogJson](#auditlogjson) > array|
|**bundleId**  <br>*optional*|string (uuid)|
|**events**  <br>*optional*|< [EventSubscriptionJson](#eventsubscriptionjson) > array|
|**externalKey**  <br>*optional*|string|


<a name="clockresource"></a>
## ClockResource

|Name|Schema|
|---|---|
|**currentUtcTime**  <br>*optional*|string (date-time)|
|**localDate**  <br>*optional*|string (date)|
|**timeZone**  <br>*optional*|string|


<a name="combopaymenttransactionjson"></a>
## ComboPaymentTransactionJson

|Name|Schema|
|---|---|
|**account**  <br>*optional*|[AccountJson](#accountjson)|
|**auditLogs**  <br>*optional*|< [AuditLogJson](#auditlogjson) > array|
|**paymentMethod**  <br>*optional*|[PaymentMethodJson](#paymentmethodjson)|
|**paymentMethodPluginProperties**  <br>*optional*|[IterablePluginPropertyJson](#iterablepluginpropertyjson)|
|**transaction**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|
|**transactionPluginProperties**  <br>*optional*|[IterablePluginPropertyJson](#iterablepluginpropertyjson)|
|**transactionType**  <br>*optional*|string|


<a name="creditjson"></a>
## CreditJson

|Name|Schema|
|---|---|
|**accountId**  <br>*required*|string (uuid)|
|**auditLogs**  <br>*optional*|< [AuditLogJson](#auditlogjson) > array|
|**creditAmount**  <br>*required*|number|
|**currency**  <br>*optional*|string|
|**description**  <br>*optional*|string|
|**effectiveDate**  <br>*optional*|string (date)|
|**invoiceId**  <br>*optional*|string (uuid)|
|**invoiceNumber**  <br>*optional*|string|


<a name="customfieldjson"></a>
## CustomFieldJson

|Name|Schema|
|---|---|
|**auditLogs**  <br>*optional*|< [AuditLogJson](#auditlogjson) > array|
|**customFieldId**  <br>*optional*|string (uuid)|
|**name**  <br>*required*|string|
|**objectId**  <br>*optional*|string (uuid)|
|**objectType**  <br>*optional*|enum (ACCOUNT, ACCOUNT_EMAIL, BLOCKING_STATES, BUNDLE, CUSTOM_FIELD, INVOICE, PAYMENT, TRANSACTION, INVOICE_ITEM, INVOICE_PAYMENT, SUBSCRIPTION, SUBSCRIPTION_EVENT, SERVICE_BROADCAST, PAYMENT_ATTEMPT, PAYMENT_METHOD, REFUND, TAG, TAG_DEFINITION, TENANT, TENANT_KVS)|
|**value**  <br>*required*|string|


<a name="durationjson"></a>
## DurationJson

|Name|Schema|
|---|---|
|**number**  <br>*optional*|integer (int32)|
|**unit**  <br>*optional*|enum (DAYS, MONTHS, YEARS, UNLIMITED)|


<a name="eventsubscriptionjson"></a>
## EventSubscriptionJson

|Name|Description|Schema|
|---|---|---|
|**auditLogs**  <br>*optional*||< [AuditLogJson](#auditlogjson) > array|
|**billingPeriod**  <br>*optional*||string|
|**effectiveDate**  <br>*optional*||string (date)|
|**eventId**  <br>*optional*||string|
|**eventType**  <br>*optional*||enum (START_ENTITLEMENT, START_BILLING, PAUSE_ENTITLEMENT, PAUSE_BILLING, RESUME_ENTITLEMENT, RESUME_BILLING, PHASE, CHANGE, STOP_ENTITLEMENT, STOP_BILLING, SERVICE_STATE_CHANGE)|
|**isBlockedBilling**  <br>*optional*|**Default** : `false`|boolean|
|**isBlockedEntitlement**  <br>*optional*|**Default** : `false`|boolean|
|**phase**  <br>*optional*||string|
|**priceList**  <br>*optional*||string|
|**product**  <br>*optional*||string|
|**serviceName**  <br>*optional*||string|
|**serviceStateName**  <br>*optional*||string|


<a name="invoicedryrunjson"></a>
## InvoiceDryRunJson

|Name|Schema|
|---|---|
|**billingPeriod**  <br>*optional*|string|
|**billingPolicy**  <br>*optional*|string|
|**bundleId**  <br>*optional*|string|
|**dryRunAction**  <br>*optional*|string|
|**dryRunType**  <br>*optional*|string|
|**effectiveDate**  <br>*optional*|string (date)|
|**phaseType**  <br>*optional*|string|
|**priceListName**  <br>*optional*|string|
|**priceOverrides**  <br>*optional*|< [PhasePriceOverrideJson](#phasepriceoverridejson) > array|
|**productCategory**  <br>*optional*|string|
|**productName**  <br>*optional*|string|
|**subscriptionId**  <br>*optional*|string|


<a name="invoiceemailjson"></a>
## InvoiceEmailJson

|Name|Description|Schema|
|---|---|---|
|**accountId**  <br>*optional*||string (uuid)|
|**auditLogs**  <br>*optional*||< [AuditLogJson](#auditlogjson) > array|
|**isNotifiedForInvoices**  <br>*optional*|**Default** : `false`|boolean|


<a name="invoiceitemjson"></a>
## InvoiceItemJson

|Name|Schema|
|---|---|
|**accountId**  <br>*required*|string (uuid)|
|**amount**  <br>*optional*|number|
|**auditLogs**  <br>*optional*|< [AuditLogJson](#auditlogjson) > array|
|**bundleId**  <br>*optional*|string (uuid)|
|**childAccountId**  <br>*optional*|string (uuid)|
|**childItems**  <br>*optional*|< [InvoiceItemJson](#invoiceitemjson) > array|
|**currency**  <br>*optional*|string|
|**description**  <br>*optional*|string|
|**endDate**  <br>*optional*|string (date)|
|**invoiceId**  <br>*optional*|string (uuid)|
|**invoiceItemId**  <br>*required*|string (uuid)|
|**itemType**  <br>*optional*|string|
|**linkedInvoiceItemId**  <br>*optional*|string (uuid)|
|**phaseName**  <br>*optional*|string|
|**planName**  <br>*optional*|string|
|**startDate**  <br>*optional*|string (date)|
|**subscriptionId**  <br>*optional*|string (uuid)|
|**usageName**  <br>*optional*|string|


<a name="invoicejson"></a>
## InvoiceJson

|Name|Description|Schema|
|---|---|---|
|**accountId**  <br>*optional*||string (uuid)|
|**amount**  <br>*optional*||number|
|**auditLogs**  <br>*optional*||< [AuditLogJson](#auditlogjson) > array|
|**balance**  <br>*optional*||number|
|**bundleKeys**  <br>*optional*||string|
|**creditAdj**  <br>*optional*||number|
|**credits**  <br>*optional*||< [CreditJson](#creditjson) > array|
|**currency**  <br>*optional*||string|
|**invoiceDate**  <br>*optional*||string (date)|
|**invoiceId**  <br>*optional*||string (uuid)|
|**invoiceNumber**  <br>*optional*||string|
|**isParentInvoice**  <br>*optional*|**Default** : `false`|boolean|
|**items**  <br>*optional*||< [InvoiceItemJson](#invoiceitemjson) > array|
|**refundAdj**  <br>*optional*||number|
|**status**  <br>*optional*||string|
|**targetDate**  <br>*optional*||string (date)|


<a name="invoicepaymentjson"></a>
## InvoicePaymentJson

|Name|Schema|
|---|---|
|**accountId**  <br>*optional*|string (uuid)|
|**auditLogs**  <br>*optional*|< [AuditLogJson](#auditlogjson) > array|
|**authAmount**  <br>*optional*|number|
|**capturedAmount**  <br>*optional*|number|
|**creditedAmount**  <br>*optional*|number|
|**currency**  <br>*optional*|string|
|**paymentAttempts**  <br>*optional*|< [PaymentAttemptJson](#paymentattemptjson) > array|
|**paymentExternalKey**  <br>*optional*|string|
|**paymentId**  <br>*optional*|string (uuid)|
|**paymentMethodId**  <br>*optional*|string (uuid)|
|**paymentNumber**  <br>*optional*|string|
|**purchasedAmount**  <br>*optional*|number|
|**refundedAmount**  <br>*optional*|number|
|**targetInvoiceId**  <br>*optional*|string (uuid)|
|**transactions**  <br>*optional*|< [PaymentTransactionJson](#paymenttransactionjson) > array|


<a name="invoicepaymenttransactionjson"></a>
## InvoicePaymentTransactionJson
Payment transaction


|Name|Description|Schema|
|---|---|---|
|**adjustments**  <br>*optional*||< [InvoiceItemJson](#invoiceitemjson) > array|
|**amount**  <br>*optional*|Transaction amount, required except for void operations|number|
|**auditLogs**  <br>*optional*||< [AuditLogJson](#auditlogjson) > array|
|**currency**  <br>*optional*|Amount currency (account currency unless specified)|enum (AED, AFN, ALL, AMD, ANG, AOA, ARS, AUD, AWG, AZN, BAM, BBD, BDT, BGN, BHD, BIF, BMD, BND, BOB, BRL, BSD, BTN, BWP, BYR, BZD, CAD, CDF, CHF, CLP, CNY, COP, CRC, CUC, CUP, CVE, CZK, DJF, DKK, DOP, DZD, EGP, ERN, ETB, EUR, FJD, FKP, GBP, GEL, GGP, GHS, GIP, GMD, GNF, GTQ, GYD, HKD, HNL, HRK, HTG, HUF, IDR, ILS, IMP, INR, IQD, IRR, ISK, JEP, JMD, JOD, JPY, KES, KGS, KHR, KMF, KPW, KRW, KWD, KYD, KZT, LAK, LBP, LKR, LRD, LSL, LTL, LVL, LYD, MAD, MDL, MGA, MKD, MMK, MNT, MOP, MRO, MUR, MVR, MWK, MXN, MYR, MZN, NAD, NGN, NIO, NOK, NPR, NZD, OMR, PAB, PEN, PGK, PHP, PKR, PLN, PYG, QAR, RON, RSD, RUB, RWF, SAR, SBD, SCR, SDG, SEK, SGD, SHP, SLL, SOS, SPL, SRD, STD, SVC, SYP, SZL, THB, TJS, TMT, TND, TOP, TRY, TTD, TVD, TWD, TZS, UAH, UGX, USD, UYU, UZS, VEF, VND, VUV, WST, XAF, XCD, XDR, XOF, XPF, YER, ZAR, ZMW, ZWD, BTC)|
|**effectiveDate**  <br>*optional*||string (date-time)|
|**firstPaymentReferenceId**  <br>*optional*||string|
|**gatewayErrorCode**  <br>*optional*||string|
|**gatewayErrorMsg**  <br>*optional*||string|
|**isAdjusted**  <br>*optional*|**Default** : `false`|boolean|
|**paymentExternalKey**  <br>*optional*||string|
|**paymentId**  <br>*optional*|Associated payment id, required when notifying state transitions|string (uuid)|
|**processedAmount**  <br>*optional*||number|
|**processedCurrency**  <br>*optional*||string|
|**properties**  <br>*optional*||< [PluginPropertyJson](#pluginpropertyjson) > array|
|**secondPaymentReferenceId**  <br>*optional*||string|
|**status**  <br>*optional*|Transaction status, required for state change notifications|enum (SUCCESS, UNKNOWN, PENDING, PAYMENT_FAILURE, PLUGIN_FAILURE, PAYMENT_SYSTEM_OFF)|
|**transactionExternalKey**  <br>*optional*||string|
|**transactionId**  <br>*optional*||string (uuid)|
|**transactionType**  <br>*optional*||enum (AUTHORIZE, CAPTURE, CHARGEBACK, CREDIT, PURCHASE, REFUND, VOID)|


<a name="iterablepluginpropertyjson"></a>
## IterablePluginPropertyJson
*Type* : object


<a name="listinvoiceitemjson"></a>
## ListInvoiceItemJson
*Type* : < [InvoiceItemJson](#invoiceitemjson) > array


<a name="notificationrulejson"></a>
## NotificationRuleJson

|Name|Schema|
|---|---|
|**FAILED_PAYMENT**  <br>*optional*|boolean|
|**INVOICE**  <br>*optional*|boolean|
|**PAYMENT_REFUND**  <br>*optional*|boolean|
|**SUBSCRIPTION_CANCELLATION_EFFECTIVE**  <br>*optional*|boolean|
|**SUBSCRIPTION_CANCELLATION_REQUESTED**  <br>*optional*|boolean|
|**SUCCESSFUL_PAYMENT**  <br>*optional*|boolean|


<a name="organizationemailjson"></a>
## OrganizationEmailJson

|Name|Schema|
|---|---|
|**email**  <br>*optional*|string|
|**id**  <br>*optional*|string|
|**is_active**  <br>*optional*|string|
|**is_default**  <br>*optional*|string|
|**organization_id**  <br>*optional*|string|
|**reg_dt**  <br>*optional*|string|


<a name="organizationjson"></a>
## OrganizationJson

|Name|Schema|
|---|---|
|**address1**  <br>*optional*|string|
|**address2**  <br>*optional*|string|
|**city**  <br>*optional*|string|
|**company_name**  <br>*optional*|string|
|**country**  <br>*optional*|string|
|**currency**  <br>*optional*|string|
|**date_format**  <br>*optional*|string|
|**fax**  <br>*optional*|string|
|**id**  <br>*optional*|string|
|**is_active**  <br>*optional*|string|
|**language_code**  <br>*optional*|string|
|**name**  <br>*optional*|string|
|**notes**  <br>*optional*|string|
|**phone**  <br>*optional*|string|
|**postal_code**  <br>*optional*|string|
|**reg_dt**  <br>*optional*|string|
|**state_or_province**  <br>*optional*|string|
|**tenant_api_key**  <br>*optional*|string|
|**tenant_api_salt**  <br>*optional*|string|
|**tenant_api_secret**  <br>*optional*|string|
|**tenant_external_key**  <br>*optional*|string|
|**tenant_id**  <br>*optional*|string|
|**time_zone**  <br>*optional*|string|
|**website**  <br>*optional*|string|


<a name="overdueconditionjson"></a>
## OverdueConditionJson

|Name|Schema|
|---|---|
|**controlTagExclusion**  <br>*optional*|enum (AUTO_PAY_OFF, AUTO_INVOICING_OFF, OVERDUE_ENFORCEMENT_OFF, WRITTEN_OFF, MANUAL_PAY, TEST, PARTNER)|
|**controlTagInclusion**  <br>*optional*|enum (AUTO_PAY_OFF, AUTO_INVOICING_OFF, OVERDUE_ENFORCEMENT_OFF, WRITTEN_OFF, MANUAL_PAY, TEST, PARTNER)|
|**numberOfUnpaidInvoicesEqualsOrExceeds**  <br>*optional*|integer (int32)|
|**responseForLastFailedPayment**  <br>*optional*|< enum (INVALID_CARD, EXPIRED_CARD, LOST_OR_STOLEN_CARD, DO_NOT_HONOR, INSUFFICIENT_FUNDS, DECLINE, PROCESSING_ERROR, INVALID_AMOUNT, DUPLICATE_TRANSACTION, OTHER) > array|
|**timeSinceEarliestUnpaidInvoiceEqualsOrExceeds**  <br>*optional*|[DurationJson](#durationjson)|
|**totalUnpaidInvoiceBalanceEqualsOrExceeds**  <br>*optional*|number|


<a name="overduejson"></a>
## OverdueJson

|Name|Schema|
|---|---|
|**initialReevaluationInterval**  <br>*optional*|integer (int32)|
|**overdueStates**  <br>*optional*|< [OverdueStateConfigJson](#overduestateconfigjson) > array|


<a name="overduestateconfigjson"></a>
## OverdueStateConfigJson

|Name|Description|Schema|
|---|---|---|
|**autoReevaluationIntervalDays**  <br>*optional*||integer (int32)|
|**blockChanges**  <br>*optional*|**Default** : `false`|boolean|
|**condition**  <br>*optional*||[OverdueConditionJson](#overdueconditionjson)|
|**disableEntitlement**  <br>*optional*|**Default** : `false`|boolean|
|**externalMessage**  <br>*optional*||string|
|**isClearState**  <br>*optional*|**Default** : `false`|boolean|
|**name**  <br>*optional*||string|
|**subscriptionCancellationPolicy**  <br>*optional*||enum (END_OF_TERM, IMMEDIATE, NONE)|


<a name="overduestatejson"></a>
## OverdueStateJson

|Name|Description|Schema|
|---|---|---|
|**blockChanges**  <br>*optional*|**Default** : `false`|boolean|
|**clearState**  <br>*optional*|**Default** : `false`|boolean|
|**daysBetweenPaymentRetries**  <br>*optional*||< integer (int32) > array|
|**disableEntitlementAndChangesBlocked**  <br>*optional*|**Default** : `false`|boolean|
|**externalMessage**  <br>*optional*||string|
|**name**  <br>*optional*||string|
|**reevaluationIntervalDays**  <br>*optional*||integer (int32)|


<a name="paymentattemptjson"></a>
## PaymentAttemptJson
Payment attempt


|Name|Description|Schema|
|---|---|---|
|**accountId**  <br>*optional*||string (uuid)|
|**amount**  <br>*optional*|Transaction amount, required except for void operations|number|
|**auditLogs**  <br>*optional*||< [AuditLogJson](#auditlogjson) > array|
|**currency**  <br>*optional*|Amount currency (account currency unless specified)|enum (AED, AFN, ALL, AMD, ANG, AOA, ARS, AUD, AWG, AZN, BAM, BBD, BDT, BGN, BHD, BIF, BMD, BND, BOB, BRL, BSD, BTN, BWP, BYR, BZD, CAD, CDF, CHF, CLP, CNY, COP, CRC, CUC, CUP, CVE, CZK, DJF, DKK, DOP, DZD, EGP, ERN, ETB, EUR, FJD, FKP, GBP, GEL, GGP, GHS, GIP, GMD, GNF, GTQ, GYD, HKD, HNL, HRK, HTG, HUF, IDR, ILS, IMP, INR, IQD, IRR, ISK, JEP, JMD, JOD, JPY, KES, KGS, KHR, KMF, KPW, KRW, KWD, KYD, KZT, LAK, LBP, LKR, LRD, LSL, LTL, LVL, LYD, MAD, MDL, MGA, MKD, MMK, MNT, MOP, MRO, MUR, MVR, MWK, MXN, MYR, MZN, NAD, NGN, NIO, NOK, NPR, NZD, OMR, PAB, PEN, PGK, PHP, PKR, PLN, PYG, QAR, RON, RSD, RUB, RWF, SAR, SBD, SCR, SDG, SEK, SGD, SHP, SLL, SOS, SPL, SRD, STD, SVC, SYP, SZL, THB, TJS, TMT, TND, TOP, TRY, TTD, TVD, TWD, TZS, UAH, UGX, USD, UYU, UZS, VEF, VND, VUV, WST, XAF, XCD, XDR, XOF, XPF, YER, ZAR, ZMW, ZWD, BTC)|
|**effectiveDate**  <br>*optional*||string (date-time)|
|**paymentExternalKey**  <br>*optional*||string|
|**paymentMethodId**  <br>*optional*||string (uuid)|
|**pluginName**  <br>*optional*||string|
|**pluginProperties**  <br>*optional*||< [PluginPropertyJson](#pluginpropertyjson) > array|
|**stateName**  <br>*optional*||string|
|**transactionExternalKey**  <br>*optional*||string|
|**transactionId**  <br>*optional*||string (uuid)|
|**transactionType**  <br>*optional*||enum (AUTHORIZE, CAPTURE, CHARGEBACK, CREDIT, PURCHASE, REFUND, VOID)|


<a name="paymentjson"></a>
## PaymentJson

|Name|Schema|
|---|---|
|**accountId**  <br>*optional*|string (uuid)|
|**auditLogs**  <br>*optional*|< [AuditLogJson](#auditlogjson) > array|
|**authAmount**  <br>*optional*|number|
|**capturedAmount**  <br>*optional*|number|
|**creditedAmount**  <br>*optional*|number|
|**currency**  <br>*optional*|string|
|**paymentAttempts**  <br>*optional*|< [PaymentAttemptJson](#paymentattemptjson) > array|
|**paymentExternalKey**  <br>*optional*|string|
|**paymentId**  <br>*optional*|string (uuid)|
|**paymentMethodId**  <br>*optional*|string (uuid)|
|**paymentNumber**  <br>*optional*|string|
|**purchasedAmount**  <br>*optional*|number|
|**refundedAmount**  <br>*optional*|number|
|**transactions**  <br>*optional*|< [PaymentTransactionJson](#paymenttransactionjson) > array|


<a name="paymentmethodjson"></a>
## PaymentMethodJson

|Name|Description|Schema|
|---|---|---|
|**accountId**  <br>*optional*||string (uuid)|
|**auditLogs**  <br>*optional*||< [AuditLogJson](#auditlogjson) > array|
|**externalKey**  <br>*optional*||string|
|**isDefault**  <br>*optional*|**Default** : `false`|boolean|
|**paymentMethodId**  <br>*optional*||string (uuid)|
|**pluginInfo**  <br>*optional*||[PaymentMethodPluginDetailJson](#paymentmethodplugindetailjson)|
|**pluginName**  <br>*optional*||string|


<a name="paymentmethodplugindetailjson"></a>
## PaymentMethodPluginDetailJson

|Name|Description|Schema|
|---|---|---|
|**externalPaymentMethodId**  <br>*optional*||string|
|**isDefaultPaymentMethod**  <br>*optional*|**Default** : `false`|boolean|
|**properties**  <br>*optional*||< [PluginPropertyJson](#pluginpropertyjson) > array|


<a name="paymenttransactionjson"></a>
## PaymentTransactionJson
Payment transaction


|Name|Description|Schema|
|---|---|---|
|**amount**  <br>*optional*|Transaction amount, required except for void operations|number|
|**auditLogs**  <br>*optional*||< [AuditLogJson](#auditlogjson) > array|
|**currency**  <br>*optional*|Amount currency (account currency unless specified)|enum (AED, AFN, ALL, AMD, ANG, AOA, ARS, AUD, AWG, AZN, BAM, BBD, BDT, BGN, BHD, BIF, BMD, BND, BOB, BRL, BSD, BTN, BWP, BYR, BZD, CAD, CDF, CHF, CLP, CNY, COP, CRC, CUC, CUP, CVE, CZK, DJF, DKK, DOP, DZD, EGP, ERN, ETB, EUR, FJD, FKP, GBP, GEL, GGP, GHS, GIP, GMD, GNF, GTQ, GYD, HKD, HNL, HRK, HTG, HUF, IDR, ILS, IMP, INR, IQD, IRR, ISK, JEP, JMD, JOD, JPY, KES, KGS, KHR, KMF, KPW, KRW, KWD, KYD, KZT, LAK, LBP, LKR, LRD, LSL, LTL, LVL, LYD, MAD, MDL, MGA, MKD, MMK, MNT, MOP, MRO, MUR, MVR, MWK, MXN, MYR, MZN, NAD, NGN, NIO, NOK, NPR, NZD, OMR, PAB, PEN, PGK, PHP, PKR, PLN, PYG, QAR, RON, RSD, RUB, RWF, SAR, SBD, SCR, SDG, SEK, SGD, SHP, SLL, SOS, SPL, SRD, STD, SVC, SYP, SZL, THB, TJS, TMT, TND, TOP, TRY, TTD, TVD, TWD, TZS, UAH, UGX, USD, UYU, UZS, VEF, VND, VUV, WST, XAF, XCD, XDR, XOF, XPF, YER, ZAR, ZMW, ZWD, BTC)|
|**effectiveDate**  <br>*optional*||string (date-time)|
|**firstPaymentReferenceId**  <br>*optional*||string|
|**gatewayErrorCode**  <br>*optional*||string|
|**gatewayErrorMsg**  <br>*optional*||string|
|**paymentExternalKey**  <br>*optional*||string|
|**paymentId**  <br>*optional*|Associated payment id, required when notifying state transitions|string (uuid)|
|**processedAmount**  <br>*optional*||number|
|**processedCurrency**  <br>*optional*||string|
|**properties**  <br>*optional*||< [PluginPropertyJson](#pluginpropertyjson) > array|
|**secondPaymentReferenceId**  <br>*optional*||string|
|**status**  <br>*optional*|Transaction status, required for state change notifications|enum (SUCCESS, UNKNOWN, PENDING, PAYMENT_FAILURE, PLUGIN_FAILURE, PAYMENT_SYSTEM_OFF)|
|**transactionExternalKey**  <br>*optional*||string|
|**transactionId**  <br>*optional*||string (uuid)|
|**transactionType**  <br>*optional*||enum (AUTHORIZE, CAPTURE, CHARGEBACK, CREDIT, PURCHASE, REFUND, VOID)|


<a name="phasejson"></a>
## PhaseJson

|Name|Schema|
|---|---|
|**duration**  <br>*optional*|[DurationJson](#durationjson)|
|**fixed**  <br>*optional*|[fixedJson](#fixedjson)|
|**recurring**  <br>*optional*|[recurringJson](#recurringjson)|
|**type**  <br>*optional*|enum (TRIAL, DISCOUNT, FIXEDTERM, EVERGREEN)|
|**usages**  <br>*optional*|< [UsageJson](#usagejson) > array|


<a name="phasepriceoverridejson"></a>
## PhasePriceOverrideJson

|Name|Schema|
|---|---|
|**fixedPrice**  <br>*optional*|number|
|**phaseName**  <br>*optional*|string|
|**phaseType**  <br>*optional*|string|
|**recurringPrice**  <br>*optional*|number|


<a name="planjson"></a>
## PlanJson

|Name|Schema|
|---|---|
|**display_name**  <br>*optional*|string|
|**finalPhase**  <br>*optional*|[PhaseJson](#phasejson)|
|**initialPhases**  <br>*optional*|< [PhaseJson](#phasejson) > array|
|**is_active**  <br>*optional*|enum (Y, N)|
|**name**  <br>*optional*|string|
|**number_of_subscriptions**  <br>*optional*|number|
|**number_of_subscriptions_referenced_by_version**  <br>*optional*|number|


<a name="pluginpropertyjson"></a>
## PluginPropertyJson

|Name|Description|Schema|
|---|---|---|
|**isUpdatable**  <br>*optional*|**Default** : `false`|boolean|
|**key**  <br>*optional*||string|
|**value**  <br>*optional*||string|


<a name="pricejson"></a>
## PriceJson

|Name|Schema|
|---|---|
|**currency**  <br>*optional*|string|
|**value**  <br>*optional*|number|


<a name="productjson"></a>
## ProductJson

|Name|Schema|
|---|---|
|**category**  <br>*optional*|enum (BASE, ADD_ON)|
|**description**  <br>*optional*|string|
|**id**  <br>*optional*|string|
|**is_active**  <br>*optional*|enum (Y, N)|
|**name**  <br>*optional*|string|
|**organization_id**  <br>*optional*|string|
|**owner_account_id**  <br>*optional*|string|
|**plan_seq**  <br>*optional*|number|
|**record_id**  <br>*optional*|number|
|**redirect_url**  <br>*optional*|string|
|**reg_dt**  <br>*optional*|string|
|**tenant_id**  <br>*optional*|string|
|**usage_seq**  <br>*optional*|number|


<a name="productversionjson"></a>
## ProductVersionJson

|Name|Schema|
|---|---|
|**effective_date**  <br>*optional*|string|
|**id**  <br>*optional*|number|
|**is_current**  <br>*optional*|enum (Y, N)|
|**organization_id**  <br>*optional*|string|
|**plans**  <br>*optional*|< [PlanJson](#planjson) > array|
|**product_id**  <br>*optional*|string|
|**reg_dt**  <br>*optional*|string|
|**tenant_id**  <br>*optional*|string|
|**version**  <br>*optional*|number|


<a name="retryrulejson"></a>
## RetryRuleJson

|Name|Schema|
|---|---|
|**retry**  <br>*optional*|string|


<a name="rolledupunitjson"></a>
## RolledUpUnitJson

|Name|Schema|
|---|---|
|**amount**  <br>*optional*|integer (int64)|
|**unitType**  <br>*optional*|string|


<a name="rolledupusagejson"></a>
## RolledUpUsageJson

|Name|Schema|
|---|---|
|**endDate**  <br>*optional*|string (date)|
|**rolledUpUnits**  <br>*optional*|< [RolledUpUnitJson](#rolledupunitjson) > array|
|**startDate**  <br>*optional*|string (date)|
|**subscriptionId**  <br>*optional*|string (uuid)|


<a name="subscriptionjson"></a>
## SubscriptionJson

|Name|Schema|
|---|---|
|**accountId**  <br>*optional*|string (uuid)|
|**auditLogs**  <br>*optional*|< [AuditLogJson](#auditlogjson) > array|
|**billCycleDayLocal**  <br>*optional*|integer (int32)|
|**billingEndDate**  <br>*optional*|string (date)|
|**billingPeriod**  <br>*required*|enum (DAILY, WEEKLY, BIWEEKLY, THIRTY_DAYS, MONTHLY, QUARTERLY, BIANNUAL, ANNUAL, BIENNIAL, NO_BILLING_PERIOD)|
|**billingStartDate**  <br>*optional*|string (date)|
|**bundleId**  <br>*optional*|string (uuid)|
|**cancelledDate**  <br>*optional*|string (date)|
|**chargedThroughDate**  <br>*optional*|string (date)|
|**events**  <br>*optional*|< [EventSubscriptionJson](#eventsubscriptionjson) > array|
|**externalKey**  <br>*optional*|string|
|**phaseType**  <br>*optional*|enum (TRIAL, DISCOUNT, FIXEDTERM, EVERGREEN)|
|**planName**  <br>*required*|string|
|**priceList**  <br>*required*|string|
|**priceOverrides**  <br>*optional*|< [PhasePriceOverrideJson](#phasepriceoverridejson) > array|
|**productCategory**  <br>*required*|enum (BASE, ADD_ON, STANDALONE)|
|**productName**  <br>*required*|string|
|**sourceType**  <br>*optional*|enum (NATIVE, MIGRATED, TRANSFERRED)|
|**startDate**  <br>*optional*|string (date)|
|**state**  <br>*optional*|enum (PENDING, ACTIVE, BLOCKED, CANCELLED)|
|**subscriptionId**  <br>*optional*|string (uuid)|


<a name="subscriptionusagerecordjson"></a>
## SubscriptionUsageRecordJson

|Name|Schema|
|---|---|
|**subscriptionId**  <br>*required*|string (uuid)|
|**trackingId**  <br>*optional*|string|
|**unitUsageRecords**  <br>*required*|< [UnitUsageRecordJson](#unitusagerecordjson) > array|


<a name="tagdefinitionjson"></a>
## TagDefinitionJson

|Name|Description|Schema|
|---|---|---|
|**applicableObjectTypes**  <br>*optional*||< string > array|
|**auditLogs**  <br>*optional*||< [AuditLogJson](#auditlogjson) > array|
|**description**  <br>*required*||string|
|**id**  <br>*optional*||string (uuid)|
|**isControlTag**  <br>*optional*|**Default** : `false`|boolean|
|**name**  <br>*required*||string|


<a name="tagjson"></a>
## TagJson

|Name|Schema|
|---|---|
|**auditLogs**  <br>*optional*|< [AuditLogJson](#auditlogjson) > array|
|**objectId**  <br>*optional*|string (uuid)|
|**objectType**  <br>*optional*|enum (ACCOUNT, ACCOUNT_EMAIL, BLOCKING_STATES, BUNDLE, CUSTOM_FIELD, INVOICE, PAYMENT, TRANSACTION, INVOICE_ITEM, INVOICE_PAYMENT, SUBSCRIPTION, SUBSCRIPTION_EVENT, SERVICE_BROADCAST, PAYMENT_ATTEMPT, PAYMENT_METHOD, REFUND, TAG, TAG_DEFINITION, TENANT, TENANT_KVS)|
|**tagDefinitionId**  <br>*optional*|string (uuid)|
|**tagDefinitionName**  <br>*optional*|string|
|**tagId**  <br>*optional*|string (uuid)|


<a name="templatejson"></a>
## TemplateJson

|Name|Schema|
|---|---|
|**body**  <br>*optional*|string|
|**is_default**  <br>*optional*|enum (Y, N)|
|**locale**  <br>*optional*|string|
|**notification_type**  <br>*optional*|enum (INVOICE, SUCCESSFUL_PAYMENT, FAILED_PAYMENT, SUBSCRIPTION_CANCELLATION_REQUESTED, SUBSCRIPTION_CANCELLATION_EFFECTIVE, PAYMENT_REFUND)|
|**organization_id**  <br>*optional*|string|
|**record_id**  <br>*optional*|number|
|**reg_dt**  <br>*optional*|string|
|**subject**  <br>*optional*|string|
|**tenant_id**  <br>*optional*|string|
|**tenant_record_id**  <br>*optional*|number|


<a name="templatepernotificationjson"></a>
## TemplatePerNotificationJson

|Name|Schema|
|---|---|
|**FAILED_PAYMENT**  <br>*optional*|< [TemplateJson](#templatejson) > array|
|**INVOICE**  <br>*optional*|< [TemplateJson](#templatejson) > array|
|**PAYMENT_REFUND**  <br>*optional*|< [TemplateJson](#templatejson) > array|
|**SUBSCRIPTION_CANCELLATION_EFFECTIVE**  <br>*optional*|< [TemplateJson](#templatejson) > array|
|**SUBSCRIPTION_CANCELLATION_REQUESTED**  <br>*optional*|< [TemplateJson](#templatejson) > array|
|**SUCCESSFUL_PAYMENT**  <br>*optional*|< [TemplateJson](#templatejson) > array|


<a name="tenantjson"></a>
## TenantJson

|Name|Schema|
|---|---|
|**apiKey**  <br>*required*|string|
|**apiSecret**  <br>*required*|string|
|**auditLogs**  <br>*optional*|< [AuditLogJson](#auditlogjson) > array|
|**externalKey**  <br>*optional*|string|
|**tenantId**  <br>*optional*|string (uuid)|


<a name="tenantkeyjson"></a>
## TenantKeyJson

|Name|Schema|
|---|---|
|**key**  <br>*optional*|string|
|**values**  <br>*optional*|< string > array|


<a name="tierjson"></a>
## TierJson

|Name|Schema|
|---|---|
|**max**  <br>*optional*|number|
|**prices**  <br>*optional*|< [PriceJson](#pricejson) > array|
|**size**  <br>*optional*|number|
|**unit**  <br>*optional*|string|


<a name="tokenjson"></a>
## TokenJson

|Name|Description|Schema|
|---|---|---|
|**access_token**  <br>*optional*||string|
|**expires_in**  <br>*optional*||number|
|**refresh_token**  <br>*optional*||string|
|**status**  <br>*optional*||number|
|**token_type**  <br>*optional*|**Default** : `"JWT"`|string|


<a name="unitusagerecordjson"></a>
## UnitUsageRecordJson

|Name|Schema|
|---|---|
|**unitType**  <br>*optional*|string|
|**usageRecords**  <br>*optional*|< [UsageRecordJson](#usagerecordjson) > array|


<a name="usagejson"></a>
## UsageJson

|Name|Schema|
|---|---|
|**billingMode**  <br>*optional*|enum (IN_ADVANCE, IN_ARREAR)|
|**billingPeriod**  <br>*optional*|enum (DAILY, WEEKLY, BIWEEKLY, THIRTY_DAYS, MONTHLY, QUARTERLY, BIANNUAL, ANNUAL, BIENNIAL, NO_BILLING_PERIOD)|
|**display_name**  <br>*optional*|string|
|**name**  <br>*optional*|string|
|**tiers**  <br>*optional*|< [TierJson](#tierjson) > array|
|**usageType**  <br>*optional*|enum (CAPACITY, CONSUMABLE)|


<a name="usagerecordjson"></a>
## UsageRecordJson

|Name|Schema|
|---|---|
|**amount**  <br>*optional*|integer (int64)|
|**recordDate**  <br>*optional*|string (date)|


<a name="userjson"></a>
## UserJson

|Name|Description|Schema|
|---|---|---|
|**_id**  <br>*optional*||string|
|**_rev**  <br>*optional*||string|
|**docType**  <br>*optional*|**Default** : `"oauth_user"`|string|
|**email**  <br>*optional*||string|
|**enable**  <br>*optional*|**Default** : `true`|boolean|
|**level**  <br>*optional*||number|
|**managementId**  <br>*optional*||string|
|**regDate**  <br>*optional*||number|
|**updDate**  <br>*optional*||number|
|**userName**  <br>*optional*||string|


<a name="billingalignmentjson"></a>
## billingAlignmentJson

|Name|Schema|
|---|---|
|**billingAlignment**  <br>*optional*|enum (ACCOUNT, BUNDLE, SUBSCRIPTION)|
|**billingPeriod**  <br>*optional*|enum (DAILY, WEEKLY, BIWEEKLY, THIRTY_DAYS, MONTHLY, QUARTERLY, BIANNUAL, ANNUAL, BIENNIAL, NO_BILLING_PERIOD)|
|**phaseType**  <br>*optional*|enum (TRIAL, DISCOUNT, FIXEDTERM, EVERGREEN)|
|**productCategory**  <br>*optional*|enum (BASE, ADD_ON)|


<a name="cancelpolicyjson"></a>
## cancelPolicyJson

|Name|Schema|
|---|---|
|**billingActionPolicy**  <br>*optional*|enum (START_OF_TERM, END_OF_TERM, IMMEDIATE, ILLEGAL)|
|**billingPeriod**  <br>*optional*|enum (DAILY, WEEKLY, BIWEEKLY, THIRTY_DAYS, MONTHLY, QUARTERLY, BIANNUAL, ANNUAL, BIENNIAL, NO_BILLING_PERIOD)|
|**phaseType**  <br>*optional*|enum (TRIAL, DISCOUNT, FIXEDTERM, EVERGREEN)|
|**productCategory**  <br>*optional*|enum (BASE, ADD_ON)|


<a name="changealignmentjson"></a>
## changeAlignmentJson

|Name|Schema|
|---|---|
|**fromBillingPeriod**  <br>*optional*|enum (DAILY, WEEKLY, BIWEEKLY, THIRTY_DAYS, MONTHLY, QUARTERLY, BIANNUAL, ANNUAL, BIENNIAL, NO_BILLING_PERIOD)|
|**fromProductCategory**  <br>*optional*|enum (BASE, ADD_ON)|
|**phaseType**  <br>*optional*|enum (TRIAL, DISCOUNT, FIXEDTERM, EVERGREEN)|
|**planAlignmentChange**  <br>*optional*|enum (START_OF_BUNDLE, START_OF_SUBSCRIPTION, CHANGE_OF_PLAN)|
|**toBillingPeriod**  <br>*optional*|enum (DAILY, WEEKLY, BIWEEKLY, THIRTY_DAYS, MONTHLY, QUARTERLY, BIANNUAL, ANNUAL, BIENNIAL, NO_BILLING_PERIOD)|
|**toProductCategory**  <br>*optional*|enum (BASE, ADD_ON)|


<a name="changepolicyjson"></a>
## changePolicyJson

|Name|Schema|
|---|---|
|**billingActionPolicy**  <br>*optional*|enum (START_OF_TERM, END_OF_TERM, IMMEDIATE, ILLEGAL)|
|**fromBillingPeriod**  <br>*optional*|enum (DAILY, WEEKLY, BIWEEKLY, THIRTY_DAYS, MONTHLY, QUARTERLY, BIANNUAL, ANNUAL, BIENNIAL, NO_BILLING_PERIOD)|
|**fromProductCategory**  <br>*optional*|enum (BASE, ADD_ON)|
|**phaseType**  <br>*optional*|enum (TRIAL, DISCOUNT, FIXEDTERM, EVERGREEN)|
|**toBillingPeriod**  <br>*optional*|enum (DAILY, WEEKLY, BIWEEKLY, THIRTY_DAYS, MONTHLY, QUARTERLY, BIANNUAL, ANNUAL, BIENNIAL, NO_BILLING_PERIOD)|
|**toProductCategory**  <br>*optional*|enum (BASE, ADD_ON)|


<a name="createalignmentjson"></a>
## createAlignmentJson

|Name|Schema|
|---|---|
|**planAlignmentCreate**  <br>*optional*|enum (START_OF_BUNDLE, START_OF_SUBSCRIPTION)|


<a name="fixedjson"></a>
## fixedJson

|Name|Schema|
|---|---|
|**fixedPrice**  <br>*optional*|< [PriceJson](#pricejson) > array|


<a name="recurringjson"></a>
## recurringJson

|Name|Schema|
|---|---|
|**billingPeriod**  <br>*optional*|enum (DAILY, WEEKLY, BIWEEKLY, THIRTY_DAYS, MONTHLY, QUARTERLY, BIANNUAL, ANNUAL, BIENNIAL, NO_BILLING_PERIOD)|
|**recurringPrice**  <br>*optional*|< [PriceJson](#pricejson) > array|






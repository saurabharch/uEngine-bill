# uEngine Bill


<a name="overview"></a>
## Overview
유엔진 빌링은 과금 및 결제 오픈소스 플랫폼입니다.


### Version information
*Version* : 1.0


### Contact information
*Contact* : sppark@uengine.org, +821040341807, Seungpil Park, 유엔진 솔루션즈


### License information
*License* : Apache License, Version 2.0  
*License URL* : http://www.apache.org/licenses/LICENSE-2.0.html  
*Terms of service* : null


### Tags

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
* pluginsInfo
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




<a name="paths"></a>
## Resources

<a name="accounts_resource"></a>
### Accounts

<a name="createaccount"></a>
#### Create account
```
POST /rest/v1/accounts
```


##### Description
구매자 계정을 생성한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Body**|**body**  <br>*optional*|[AccountJson](#accountjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account data supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getaccountbykey"></a>
#### Retrieve an account by external key
```
GET /rest/v1/accounts
```


##### Description
External key 값으로 구매자 계정을 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**accountWithBalance**  <br>*optional*|boolean|`"false"`|
|**Query**|**accountWithBalanceAndCBA**  <br>*optional*|boolean|`"false"`|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**externalKey**  <br>*optional*|string||


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[AccountJson](#accountjson)|
|**404**|Account not found|No Content|


##### Produces

* `application/json`


<a name="getaccounts"></a>
#### List accounts
```
GET /rest/v1/accounts/pagination
```


##### Description
구매자 계정을 페이징 처리하여 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**accountWithBalance**  <br>*optional*|boolean|`"false"`|
|**Query**|**accountWithBalanceAndCBA**  <br>*optional*|boolean|`"false"`|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [AccountJson](#accountjson) > array|


##### Produces

* `application/json`


<a name="processpaymentbyexternalkey"></a>
#### Trigger a payment using the account external key (authorization, purchase or credit)
```
POST /rest/v1/accounts/payments
```


##### Description
주어진 구매자 external key 로 authorization, purchase, credit 결제를 수행한다.


##### Parameters

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


##### Responses

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


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="searchaccounts"></a>
#### Search accounts
```
GET /rest/v1/accounts/search/{searchKey}
```


##### Description
주어진 검색어에 해당하는 구매자 계정들을 페이징 처리하여 반환한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**searchKey**  <br>*required*|string||
|**Query**|**accountWithBalance**  <br>*optional*|boolean|`"false"`|
|**Query**|**accountWithBalanceAndCBA**  <br>*optional*|boolean|`"false"`|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [AccountJson](#accountjson) > array|


##### Produces

* `application/json`


<a name="getaccount"></a>
#### Retrieve an account by id
```
GET /rest/v1/accounts/{accountId}
```


##### Description
구매자 계정을 id 로 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**accountWithBalance**  <br>*optional*|boolean|`"false"`|
|**Query**|**accountWithBalanceAndCBA**  <br>*optional*|boolean|`"false"`|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[AccountJson](#accountjson)|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


##### Produces

* `application/json`


<a name="updateaccount"></a>
#### Update account
```
PUT /rest/v1/accounts/{accountId}
```


##### Description
구매자 계정 정보를 업데이트한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**accountId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|[AccountJson](#accountjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account data supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="deleteaccount"></a>
#### Remove account
```
DELETE /rest/v1/accounts/{accountId}
```


##### Description
구매자 계정을 삭제한다. 구독기록이나 결제 기록이 있다면 삭제할 수 없다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**accountId**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|successful operation|No Content|
|**400**|Invalid account delete supplied|No Content|
|**404**|Account not found|No Content|


##### Produces

* `application/json`


<a name="getalltags"></a>
#### Retrieve account tags
```
GET /rest/v1/accounts/{accountId}/allTags
```


##### Description
구매자 계정과 관련된 모든 태그들을 objectType 별로 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**includedDeleted**  <br>*optional*|boolean|`"false"`|
|**Query**|**objectType**  <br>*optional*|enum (ACCOUNT, ACCOUNT_EMAIL, BLOCKING_STATES, BUNDLE, CUSTOM_FIELD, INVOICE, PAYMENT, TRANSACTION, INVOICE_ITEM, INVOICE_PAYMENT, SUBSCRIPTION, SUBSCRIPTION_EVENT, SERVICE_BROADCAST, PAYMENT_ATTEMPT, PAYMENT_METHOD, REFUND, TAG, TAG_DEFINITION, TENANT, TENANT_KVS)||


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [TagJson](#tagjson) > array|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


##### Produces

* `application/json`


<a name="updateaccountbcd"></a>
#### Update account bcd
```
PUT /rest/v1/accounts/{accountId}/bcd
```


##### Description
구매자 계정 결제일을 업데이트 한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**accountId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|[AccountBCDJson](#accountbcdjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[AccountJson](#accountjson)|
|**400**|Invalid account bcd data supplied|No Content|
|**404**|Account Not Found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getblockingstates"></a>
#### Retrieve blocking states for account
```
GET /rest/v1/accounts/{accountId}/block
```


##### Description
구매자 계정의 blocking 이력을 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**blockingStateSvcs**  <br>*optional*|< string > array(multi)||
|**Query**|**blockingStateTypes**  <br>*optional*|< enum (SUBSCRIPTION, SUBSCRIPTION_BUNDLE, ACCOUNT) > array(multi)||


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [BlockingStateJson](#blockingstatejson) > array|
|**400**|Invalid account id supplied|No Content|


##### Produces

* `application/json`


<a name="addaccountblockingstate"></a>
#### Block an account
```
PUT /rest/v1/accounts/{accountId}/block
```


##### Description
구매자 계정을 Block 시킨다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**accountId**  <br>*required*|string|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Query**|**requestedDate**  <br>*optional*|string|
|**Body**|**body**  <br>*optional*|[BlockingStateJson](#blockingstatejson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


##### Consumes

* `application/json`


<a name="getaccountbundles"></a>
#### Retrieve bundles for account
```
GET /rest/v1/accounts/{accountId}/bundles
```


##### Description
구매자 계정이 구독중인 bundle 리스트를 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**bundlesFilter**  <br>*optional*|string||
|**Query**|**externalKey**  <br>*optional*|string||


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [BundleJson](#bundlejson) > array|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


##### Produces

* `application/json`


<a name="rebalanceexistingcbaonaccount"></a>
#### Rebalance account CBA
```
POST /rest/v1/accounts/{accountId}/cbaRebalancing
```


##### Description
구매자 계정의 가상 화폐(Credit) 를 리밸런싱한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**accountId**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getchildrenaccounts"></a>
#### List children accounts
```
GET /rest/v1/accounts/{accountId}/children
```


##### Description
구매자 계정의 하위 계정들을 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**accountWithBalance**  <br>*optional*|boolean|`"false"`|
|**Query**|**accountWithBalanceAndCBA**  <br>*optional*|boolean|`"false"`|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [AccountJson](#accountjson) > array|
|**400**|Invalid parent account id supplied|No Content|
|**404**|Parent Account not found|No Content|


##### Produces

* `application/json`


<a name="createaccountcustomfields"></a>
#### Add custom fields to account
```
POST /rest/v1/accounts/{accountId}/customFields
```


##### Description
구매자 계정에 custom field 를 추가한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**accountId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|< [CustomFieldJson](#customfieldjson) > array|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getaccountcustomfields"></a>
#### Retrieve account custom fields
```
GET /rest/v1/accounts/{accountId}/customFields
```


##### Description
구매자 계정의 custom fields 를 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [CustomFieldJson](#customfieldjson) > array|
|**400**|Invalid account id supplied|No Content|


##### Produces

* `application/json`


<a name="deleteaccountcustomfields"></a>
#### Remove custom fields from account
```
DELETE /rest/v1/accounts/{accountId}/customFields
```


##### Description
구매자 계정의 custom field 를 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**accountId**  <br>*required*|string|
|**Query**|**customFieldList**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getemailnotificationsforaccount"></a>
#### Retrieve account email notification
```
GET /rest/v1/accounts/{accountId}/emailNotifications
```


##### Description
구매자 계정으로 인보이스 발송 여부를 조회한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**accountId**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[InvoiceEmailJson](#invoiceemailjson)|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


##### Produces

* `application/json`


<a name="setemailnotificationsforaccount"></a>
#### Set account email notification
```
PUT /rest/v1/accounts/{accountId}/emailNotifications
```


##### Description
구매자 계정으로 인보이스 발송 여부를 결정한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**accountId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|[InvoiceEmailJson](#invoiceemailjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="addemail"></a>
#### Add account email
```
POST /rest/v1/accounts/{accountId}/emails
```


##### Description
인보이스 및 이메일 알림에 대해 CC(참조) 를 받는 이메일 계정을 추가한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**accountId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|[AccountEmailJson](#accountemailjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getemails"></a>
#### Retrieve an account emails
```
GET /rest/v1/accounts/{accountId}/emails
```


##### Description
인보이스 및 이메일 알림에 대해 CC(참조) 를 받는 이메일 계정 리스트를 불러온다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**accountId**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [AccountEmailJson](#accountemailjson) > array|
|**400**|Invalid account id supplied|No Content|


##### Produces

* `application/json`


<a name="removeemail"></a>
#### Delete email from account
```
DELETE /rest/v1/accounts/{accountId}/emails/{email}
```


##### Description
인보이스 및 이메일 알림에 대해 CC(참조) 를 받는 이메일 계정을 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**accountId**  <br>*required*|string|
|**Path**|**email**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|


##### Produces

* `application/json`


<a name="payallinvoices"></a>
#### Trigger a payment for all unpaid invoices
```
POST /rest/v1/accounts/{accountId}/invoicePayments
```


##### Description
구매자 계정의 모든 미결제된 인보이스에 대해 결제시도를 한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string||
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string||
|**Header**|**X-Killbill-Reason**  <br>*optional*|string||
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**externalPayment**  <br>*optional*|boolean|`"false"`|
|**Query**|**paymentAmount**  <br>*optional*|number||
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getaccountinvoicepayments"></a>
#### Retrieve account invoice payments
```
GET /rest/v1/accounts/{accountId}/invoicePayments
```


##### Description
구매자 계정의 모든 인보이스와 연계된 결제내역을 불러온다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**withAttempts**  <br>*optional*|boolean|`"false"`|
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [InvoicePaymentJson](#invoicepaymentjson) > array|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


##### Produces

* `application/json`


<a name="getaccountinvoices"></a>
#### Retrieve account invoices
```
GET /rest/v1/accounts/{accountId}/invoices
```


##### Description
구매자 계정의 모든 인보이스를 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**unpaidInvoicesOnly**  <br>*optional*|boolean|`"false"`|
|**Query**|**withItems**  <br>*optional*|boolean|`"false"`|
|**Query**|**withMigrationInvoices**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[InvoiceJson](#invoicejson)|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


##### Produces

* `application/json`


<a name="getaccountonetimebuy"></a>
#### Retrieve onetimebuy for account
```
GET /rest/v1/accounts/{accountId}/onetimebuy
```


##### Description
구매자 계정이 구매한 일회성 구매 이력을 조회한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**accountId**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [OneTimeBuyJson](#onetimebuyjson) > array|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


##### Produces

* `application/json`


<a name="getoverdueaccount"></a>
#### Retrieve overdue state for account
```
GET /rest/v1/accounts/{accountId}/overdue
```


##### Description
구매자 계정의 연체 상태를 조회한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**accountId**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[OverdueStateJson](#overduestatejson)|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


##### Produces

* `application/json`


<a name="createpaymentmethod"></a>
#### Add a payment method
```
POST /rest/v1/accounts/{accountId}/paymentMethods
```


##### Description
구매자 계정에 결제수단을 추가한다.


##### Parameters

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


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getaccountpaymentmethods"></a>
#### Retrieve account payment methods
```
GET /rest/v1/accounts/{accountId}/paymentMethods
```


##### Description
구매자 계정의 모든 결제수단을 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [PaymentMethodJson](#paymentmethodjson) > array|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


##### Produces

* `application/json`


<a name="refreshpaymentmethods"></a>
#### Refresh account payment methods
```
POST /rest/v1/accounts/{accountId}/paymentMethods/refresh
```


##### Description
구매자 계정의 결제 수단을 리프레쉬한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**accountId**  <br>*required*|string|
|**Query**|**pluginName**  <br>*optional*|string|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


##### Produces

* `application/json`


<a name="setdefaultpaymentmethod"></a>
#### Set the default payment method
```
PUT /rest/v1/accounts/{accountId}/paymentMethods/{paymentMethodId}/setDefault
```


##### Description
구매자 계정의 결제 수단을 디폴트로 지정한다. (인보이스 생성시 디폴트 결제 수단으로 결제된다.)


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string||
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string||
|**Header**|**X-Killbill-Reason**  <br>*optional*|string||
|**Path**|**accountId**  <br>*required*|string||
|**Path**|**paymentMethodId**  <br>*required*|string||
|**Query**|**payAllUnpaidInvoices**  <br>*optional*|boolean|`"false"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id or payment method id supplied|No Content|
|**404**|Account not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="processpayment"></a>
#### Trigger a payment (authorization, purchase or credit)
```
POST /rest/v1/accounts/{accountId}/payments
```


##### Description
구매자 계정으로 하여금 authorization, purchase, credit 결제를 수행한다.


##### Parameters

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


##### Responses

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


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getaccountpayments"></a>
#### Retrieve account payments
```
GET /rest/v1/accounts/{accountId}/payments
```


##### Description
구매자 계정의 결제이력을 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**withAttempts**  <br>*optional*|boolean|`"false"`|
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [PaymentJson](#paymentjson) > array|
|**400**|Invalid account id supplied|No Content|


##### Produces

* `application/json`


<a name="getaccountsalesbalance"></a>
#### get account sales balance
```
GET /rest/v1/accounts/{accountId}/sales/balance
```


##### Description
구매자 계정의 판매대금 잔액을 조회한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**accountId**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[AccountSalesBalanceJson](#accountsalesbalancejson)|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


##### Produces

* `application/json`


<a name="cancelwithdraw"></a>
#### Cancel withdraw
```
POST /rest/v1/accounts/{accountId}/sales/cancelwithdraw/{sales_record_id}
```


##### Description
판매자의 판매 잔금을 출금기록을 취소한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**accountId**  <br>*required*|string|
|**Path**|**sales_record_id**  <br>*required*|number|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|No Content|
|**400**|Invalid Request|No Content|
|**404**|Not found sales record|No Content|


##### Produces

* `application/json`


<a name="getaccountssales"></a>
#### List accounts sales history
```
GET /rest/v1/accounts/{accountId}/sales/pagination
```


##### Description
판매자의 판매 이력을 페이징 처리하여 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [ProductDistributionHistory](#productdistributionhistory) > array|


##### Produces

* `application/json`


<a name="searchaccountssales"></a>
#### Search accounts sales history
```
GET /rest/v1/accounts/{accountId}/sales/search/{searchKey}
```


##### Description
주어진 검색어에 해당하는 판매자 계정의 판매 이력을 페이징 처리하여 반환한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Path**|**searchKey**  <br>*required*|string||
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [ProductDistributionHistory](#productdistributionhistory) > array|


##### Produces

* `application/json`


<a name="getaccountsalessummary"></a>
#### get account sales summary per date
```
GET /rest/v1/accounts/{accountId}/sales/summary
```


##### Description
구매자 계정의 판매대금 합계를 기간별로 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**end_date**  <br>*optional*|string||
|**Query**|**period**  <br>*optional*|enum (DAY, MONTH, YEAR)|`"DAY"`|
|**Query**|**plan_name**  <br>*optional*|string||
|**Query**|**product_id**  <br>*optional*|string||
|**Query**|**start_date**  <br>*optional*|string||
|**Query**|**usage_name**  <br>*optional*|string||


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[SalesPerDateSummaryJson](#salesperdatesummaryjson)|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


##### Produces

* `application/json`


<a name="withdrawaccountssales"></a>
#### Withdraw accounts sales
```
POST /rest/v1/accounts/{accountId}/sales/withdraw
```


##### Description
판매자의 판매 잔금을 출금처리한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**accountId**  <br>*required*|string|
|**Body**|**body**  <br>*required*|[SalesWithdrawRequest](#saleswithdrawrequest)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|successful operation|< [ProductDistributionHistory](#productdistributionhistory) > array|
|**400**|Invalid Request|No Content|
|**404**|Not found account|No Content|


##### Produces

* `application/json`


<a name="createaccounttags"></a>
#### Add tags to account
```
POST /rest/v1/accounts/{accountId}/tags
```


##### Description
구매자 계정에 태그를 추가한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**accountId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|


##### Produces

* `application/json`


<a name="getaccounttags"></a>
#### Retrieve account tags
```
GET /rest/v1/accounts/{accountId}/tags
```


##### Description
구매자 계정의 tag 를 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**includedDeleted**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [TagJson](#tagjson) > array|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


##### Produces

* `application/json`


<a name="deleteaccounttags"></a>
#### Remove tags from account
```
DELETE /rest/v1/accounts/{accountId}/tags
```


##### Description
구매자 계정의 태그를 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**accountId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied or account does not have a default payment method (AUTO_PAY_OFF tag only)|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getaccounttimeline"></a>
#### Retrieve account timeline
```
GET /rest/v1/accounts/{accountId}/timeline
```


##### Description
구매자 계정의 모든 타임라인을 조회한다.(구독, 결제, 인보이스 이력)


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**parallel**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[AccountTimelineJson](#accounttimelinejson)|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


##### Produces

* `application/json`


<a name="addaccountunblockingstate"></a>
#### Unblock an account
```
PUT /rest/v1/accounts/{accountId}/unblock
```


##### Description
구매자 계정을 UnBlock 시킨다.


##### Parameters

|Type|Name|Description|Schema|
|---|---|---|---|
|**Path**|**accountId**  <br>*required*||string|
|**Query**|**resumeInvoice**  <br>*optional*|인보이스 생성 재시작 여부|boolean|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|No Content|
|**400**|Invalid account unblock supplied|No Content|
|**404**|Account not found|No Content|


##### Consumes

* `application/json`


<a name="transferchildcredittoparent"></a>
#### Move a given child credit to the parent level
```
POST /rest/v1/accounts/{childAccountId}/transferCredit
```


##### Description
구매자 계정의 가상 화폐(Credit) 의 잔액을 부모 계정으로 이동시킨다. (부모 계정이 있을 경우만 해당된다.)


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**childAccountId**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Account does not have credit|No Content|
|**404**|Account not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="auth_resource"></a>
### Auth

<a name="accesstoken"></a>
#### Login and get token
```
POST /rest/v1/access_token
```


##### Description
로그인 하여 토큰을 받아온다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Query**|**password**  <br>*required*|string|
|**Query**|**scope**  <br>*required*|string|
|**Query**|**username**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TokenJson](#tokenjson)|
|**400**|Invalid user information|No Content|


##### Consumes

* `application/x-www-form-urlencoded`


##### Produces

* `application/json`


<a name="tokeninfo"></a>
#### Validate token
```
GET /rest/v1/token_info
```


##### Description
토큰이 유효한지 체크한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Query**|**authorization**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[UserJson](#userjson)|
|**400**|Invalid token|No Content|


##### Produces

* `application/json`


<a name="bundles_resource"></a>
### Bundles

<a name="getbundlebykey"></a>
#### Retrieve a bundle by external key
```
GET /rest/v1/bundles
```


##### Description
주어진 external key 로 번들 한건을 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**externalKey**  <br>*optional*|string||
|**Query**|**includedDeleted**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[BundleJson](#bundlejson)|
|**404**|Bundle not found|No Content|


##### Produces

* `application/json`


<a name="getbundles"></a>
#### List bundles
```
GET /rest/v1/bundles/pagination
```


##### Description
번들을 페이징하여 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [BundleJson](#bundlejson) > array|


##### Produces

* `application/json`


<a name="searchbundles"></a>
#### Search bundles
```
GET /rest/v1/bundles/search/{searchKey}
```


##### Description
주어진 검색어로 번들을 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**searchKey**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [BundleJson](#bundlejson) > array|


##### Produces

* `application/json`


<a name="getbundle"></a>
#### Retrieve a bundle by id
```
GET /rest/v1/bundles/{bundleId}
```


##### Description
아이디로 번들을 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**bundleId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[BundleJson](#bundlejson)|
|**400**|Invalid bundle id supplied|No Content|
|**404**|Bundle not found|No Content|


##### Produces

* `application/json`


<a name="transferbundle"></a>
#### Transfer a bundle to another account
```
PUT /rest/v1/bundles/{bundleId}
```


##### Description
번들을 다른 구매자 계정으로 이전시킨다.(과금 주기 또한 동일하게 이전된다.)


##### Parameters

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


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid bundle id, requested date or policy supplied|No Content|
|**404**|Bundle not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="addbundleblockingstate"></a>
#### Block a bundle
```
PUT /rest/v1/bundles/{bundleId}/block
```


##### Description
번들을 정지시킨다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**bundleId**  <br>*required*|string|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Query**|**requestedDate**  <br>*optional*|string|
|**Body**|**body**  <br>*optional*|[BlockingStateJson](#blockingstatejson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid bundle id supplied|No Content|
|**404**|Bundle not found|No Content|


##### Consumes

* `application/json`


<a name="createbundlecustomfields"></a>
#### Add custom fields to bundle
```
POST /rest/v1/bundles/{bundleId}/customFields
```


##### Description
번들에 커스텀 필드를 추가한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**bundleId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|< [CustomFieldJson](#customfieldjson) > array|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid bundle id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getbundlecustomfields"></a>
#### Retrieve bundle custom fields
```
GET /rest/v1/bundles/{bundleId}/customFields
```


##### Description
번들의 커스텀 필드를 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**bundleId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [CustomFieldJson](#customfieldjson) > array|
|**400**|Invalid bundle id supplied|No Content|


##### Produces

* `application/json`


<a name="deletebundlecustomfields"></a>
#### Remove custom fields from bundle
```
DELETE /rest/v1/bundles/{bundleId}/customFields
```


##### Description
번들에 부여된 커스텀 필드를 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**bundleId**  <br>*required*|string|
|**Query**|**customFieldList**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid bundle id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="pausebundle"></a>
#### Pause a bundle
```
PUT /rest/v1/bundles/{bundleId}/pause
```


##### Description
번들을 일시정지 시킨다.(일시정지 된 번들을 정지 기간동안 과금이 부과되지 않는다.)


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**bundleId**  <br>*required*|string|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Query**|**requestedDate**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid bundle id supplied|No Content|
|**404**|Bundle not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="resumebundle"></a>
#### Resume a bundle
```
PUT /rest/v1/bundles/{bundleId}/resume
```


##### Description
번들의 일시정지를 해제한다. (해지된 시점부터 과금이 재집행되며, 결제 주기는 정지되기 전과 동일하게 유지된다.)


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**bundleId**  <br>*required*|string|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Query**|**requestedDate**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid bundle id supplied|No Content|
|**404**|Bundle not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="createbundletags"></a>
#### Add tags to bundle
```
POST /rest/v1/bundles/{bundleId}/tags
```


##### Description
번들에 태그를 추가한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**bundleId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid bundle id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getbundletags"></a>
#### Retrieve bundle tags
```
GET /rest/v1/bundles/{bundleId}/tags
```


##### Description
번들의 태그를 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**bundleId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**includedDeleted**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [TagJson](#tagjson) > array|
|**400**|Invalid bundle id supplied|No Content|
|**404**|Bundle not found|No Content|


##### Produces

* `application/json`


<a name="deletebundletags"></a>
#### Remove tags from bundle
```
DELETE /rest/v1/bundles/{bundleId}/tags
```


##### Description
번들에 부여된 태그를 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**bundleId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid bundle id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="credits_resource"></a>
### Credits

<a name="createcredit"></a>
#### Create a credit
```
POST /rest/v1/credits
```


##### Description
구매자 계정, 또는 인보이스에 가상 화폐를 추가한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string||
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string||
|**Header**|**X-Killbill-Reason**  <br>*optional*|string||
|**Query**|**autoCommit**  <br>*optional*|boolean|`"false"`|
|**Body**|**body**  <br>*optional*|[CreditJson](#creditjson)||


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getcredit"></a>
#### Retrieve a credit by id
```
GET /rest/v1/credits/{creditId}
```


##### Description
가장 화폐 (credit) 를 아이디로 조회한다. 구매자 계정의 가상 화폐 잔액은 credit 들의 sum 으로 계산된다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**creditId**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[CreditJson](#creditjson)|
|**400**|Invalid credit id supplied|No Content|
|**404**|Credit not found|No Content|


##### Produces

* `application/json`


<a name="customfields_resource"></a>
### CustomFields

<a name="getcustomfields"></a>
#### List custom fields
```
GET /rest/v1/customFields/pagination
```


##### Description
커스텀 필드를 페이징하여 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [CustomFieldJson](#customfieldjson) > array|


##### Produces

* `application/json`


<a name="searchcustomfields"></a>
#### Search custom fields
```
GET /rest/v1/customFields/search/{searchKey}
```


##### Description
주어진 검색어로 커스텀 필드를 페이징하여 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**searchKey**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [CustomFieldJson](#customfieldjson) > array|


##### Produces

* `application/json`


<a name="invoicepayments_resource"></a>
### InvoicePayments

<a name="getinvoicepayment"></a>
#### Retrieve a payment by id
```
GET /rest/v1/invoicePayments/{paymentId}
```


##### Description
인보이스 결제 이력을 아이디로 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**paymentId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**withAttempts**  <br>*optional*|boolean|`"false"`|
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[InvoicePaymentJson](#invoicepaymentjson)|
|**400**|Invalid payment id supplied|No Content|
|**404**|Payment not found|No Content|


##### Produces

* `application/json`


<a name="createchargebackreversal"></a>
#### Record a chargebackReversal
```
POST /rest/v1/invoicePayments/{paymentId}/chargebackReversals
```


##### Description
주어진 인보이스 결제이력의 chargeback(지불 거절) 요청을 취소한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|[InvoicePaymentTransactionJson](#invoicepaymenttransactionjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment id supplied|No Content|
|**404**|Account or payment not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="createchargeback"></a>
#### Record a chargeback
```
POST /rest/v1/invoicePayments/{paymentId}/chargebacks
```


##### Description
인보이스 결제이력에 지불거절(chargebacks) 요청을 한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|[InvoicePaymentTransactionJson](#invoicepaymenttransactionjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment id supplied|No Content|
|**404**|Account or payment not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="createinvoicepaymentcustomfields"></a>
#### Add custom fields to payment
```
POST /rest/v1/invoicePayments/{paymentId}/customFields
```


##### Description
인보이스 결제이력에 커스텀 필드를 추가한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|< [CustomFieldJson](#customfieldjson) > array|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getinvoicepaymentcustomfields"></a>
#### Retrieve payment custom fields
```
GET /rest/v1/invoicePayments/{paymentId}/customFields
```


##### Description
인보이스 결제이력의 커스텀 필드를 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**paymentId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [CustomFieldJson](#customfieldjson) > array|
|**400**|Invalid payment id supplied|No Content|


##### Produces

* `application/json`


<a name="deleteinvoicepaymentcustomfields"></a>
#### Remove custom fields from payment
```
DELETE /rest/v1/invoicePayments/{paymentId}/customFields
```


##### Description
인보이스 결제이력에 커스텀 필드를 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**customFieldList**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="createrefundwithadjustments"></a>
#### Refund a payment, and adjust the invoice if needed
```
POST /rest/v1/invoicePayments/{paymentId}/refunds
```


##### Description
인보이스 결제이력에 환불(refund) 요청을 한다. 환불 요청시, Adjust 할 인보이스 아이템(상세 항목) 및 금액을 정할 수 있다.


##### Parameters

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


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment id supplied|No Content|
|**404**|Account or payment not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="createinvoicepaymenttags"></a>
#### Add tags to payment
```
POST /rest/v1/invoicePayments/{paymentId}/tags
```


##### Description
인보이스 결제이력에 태그를 추가한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getinvoicepaymenttags"></a>
#### Retrieve payment tags
```
GET /rest/v1/invoicePayments/{paymentId}/tags
```


##### Description
인보이스 결제이력의 태그를 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**paymentId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**includedDeleted**  <br>*optional*|boolean|`"false"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [TagJson](#tagjson) > array|
|**400**|Invalid payment id supplied|No Content|
|**404**|Payment not found|No Content|


##### Produces

* `application/json`


<a name="deleteinvoicepaymenttags"></a>
#### Remove tags from payment
```
DELETE /rest/v1/invoicePayments/{paymentId}/tags
```


##### Description
인보이스 결제이력에 태그를 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="invoices_resource"></a>
### Invoices

<a name="createfutureinvoice"></a>
#### Trigger an invoice generation
```
POST /rest/v1/invoices
```


##### Description
미래에 발급될 인보이스를 앞당겨 발급한다.(인보이스가 실제로 생성,발송되고 결제도 이루어진다.) targetDate 가 마지막 인보이스로부터 다음 결제 예정일보다 이전일 경우 발급되지 않는다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Query**|**accountId**  <br>*optional*|string|
|**Query**|**targetDate**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[InvoiceJson](#invoicejson)|
|**400**|Invalid account id or target datetime supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="createexternalcharges"></a>
#### Create external charge(s)
```
POST /rest/v1/invoices/charges/{accountId}
```


##### Description
구매자에게 임의의 인보이스를 발급한다. 이 인보이스는 플랜과 상관이 없는 독립적인 인보이스이며, 임의이 설명과 함께 구매자에게 발송되며 결제된다. 만일 인보이스 아이디를 지정하게 된다면, 지정된 인보이스에 External charge item 이 추가된다. 인보이스 아이디를 지정할 경우 자동 결제 및 재발송되지 않으므로 결제 및 발송을 수행해주어야 한다.


##### Parameters

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


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [InvoiceItemJson](#invoiceitemjson) > array|
|**400**|Invalid account id supplied|No Content|
|**404**|Account not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="generatedryruninvoice"></a>
#### Generate a dryRun invoice
```
POST /rest/v1/invoices/dryRun
```


##### Description
미래에 발급될 인보이스를 가상으로 생성해 조회한다.(가상으로 생성된 인보이스는 실제로 발급되지는 않는다.)


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Query**|**accountId**  <br>*optional*|string|
|**Query**|**targetDate**  <br>*optional*|string|
|**Body**|**body**  <br>*optional*|[InvoiceDryRunJson](#invoicedryrunjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[InvoiceJson](#invoicejson)|
|**400**|Invalid account id or target datetime supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getinvoices"></a>
#### List invoices
```
GET /rest/v1/invoices/pagination
```


##### Description
인보이스를 페이징하여 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|
|**Query**|**withItems**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [InvoiceJson](#invoicejson) > array|


##### Produces

* `application/json`


<a name="searchinvoices"></a>
#### Search invoices
```
GET /rest/v1/invoices/search/{searchKey}
```


##### Description
주어진 검색어로 인보이스를 페이징하여 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**searchKey**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|
|**Query**|**withItems**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [InvoiceJson](#invoicejson) > array|


##### Produces

* `application/json`


<a name="adjustinvoiceitem"></a>
#### Adjust an invoice item
```
POST /rest/v1/invoices/{invoiceId}
```


##### Description
인보이스에 포함된 인보이스 아이템 한건을 Adjust(가격 조정) 한다


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**invoiceId**  <br>*required*|string|
|**Query**|**requestedDate**  <br>*optional*|string|
|**Body**|**body**  <br>*optional*|[InvoiceItemJson](#invoiceitemjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id, invoice id or invoice item id supplied|No Content|
|**404**|Invoice not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getinvoice"></a>
#### Retrieve an invoice by id
```
GET /rest/v1/invoices/{invoiceId}
```


##### Description
아이디 또는 인보이스 넘버에 해당하는 인보이스를 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**invoiceId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**withChildrenItems**  <br>*optional*|boolean|`"false"`|
|**Query**|**withItems**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[InvoiceJson](#invoicejson)|
|**400**|Invalid invoice id supplied|No Content|
|**404**|Invoice not found|No Content|


##### Produces

* `application/json`


<a name="commitinvoice"></a>
#### Perform the invoice status transition from DRAFT to COMMITTED
```
PUT /rest/v1/invoices/{invoiceId}/commitInvoice
```


##### Description
인보이스의 status 를 DRAFT 에서 COMMITTED 상태로 전환한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**invoiceId**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**404**|Invoice not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="createinvoicecustomfields"></a>
#### Add custom fields to invoice
```
POST /rest/v1/invoices/{invoiceId}/customFields
```


##### Description
인보이스에 커스텀 필드를 추가한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**invoiceId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|< [CustomFieldJson](#customfieldjson) > array|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid invoice id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getinvoicecustomfields"></a>
#### Retrieve invoice custom fields
```
GET /rest/v1/invoices/{invoiceId}/customFields
```


##### Description
인보이스의 커스텀 필드를 반환한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**invoiceId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [CustomFieldJson](#customfieldjson) > array|
|**400**|Invalid invoice id supplied|No Content|


##### Produces

* `application/json`


<a name="deleteinvoicecustomfields"></a>
#### Remove custom fields from invoice
```
DELETE /rest/v1/invoices/{invoiceId}/customFields
```


##### Description
인보이스에 커스텀 필드를 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**invoiceId**  <br>*required*|string|
|**Query**|**customFieldList**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid invoice id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="triggeremailnotificationforinvoice"></a>
#### Trigger an email notification for invoice
```
POST /rest/v1/invoices/{invoiceId}/emailNotifications
```


##### Description
인보이스를 구매자의 이메일 계정으로 발송한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**invoiceId**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid invoice id supplied|No Content|
|**404**|Account or invoice not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getinvoiceashtml"></a>
#### Render an invoice as HTML
```
GET /rest/v1/invoices/{invoiceId}/html
```


##### Description
인보이스를 HTML 형식으로 출력한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**invoiceId**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|string|
|**404**|Invoice not found|No Content|


##### Produces

* `text/html`


<a name="createinstantpayment"></a>
#### Trigger a payment for invoice
```
POST /rest/v1/invoices/{invoiceId}/payments
```


##### Description
인보이스의 잔액을 결제한다. 결제금액은 인보이스의 잔액보다 크지 않아야 한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string||
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string||
|**Header**|**X-Killbill-Reason**  <br>*optional*|string||
|**Path**|**invoiceId**  <br>*required*|string||
|**Query**|**externalPayment**  <br>*optional*|boolean|`"false"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Body**|**body**  <br>*optional*|[InvoicePaymentJson](#invoicepaymentjson)||


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id or invoice id supplied|No Content|
|**404**|Account not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getinvoicepayments"></a>
#### Retrieve payments associated with an invoice
```
GET /rest/v1/invoices/{invoiceId}/payments
```


##### Description
인보이스에 관련된 결제 이력을 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**invoiceId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**withAttempts**  <br>*optional*|boolean|`"false"`|
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [InvoicePaymentJson](#invoicepaymentjson) > array|
|**400**|Invalid invoice id supplied|No Content|
|**404**|Invoice not found|No Content|


##### Produces

* `application/json`


<a name="createinvoicetags"></a>
#### Add tags to invoice
```
POST /rest/v1/invoices/{invoiceId}/tags
```


##### Description
인보이스에 태그를 추가한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**invoiceId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid invoice id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getinvoicetags"></a>
#### Retrieve invoice tags
```
GET /rest/v1/invoices/{invoiceId}/tags
```


##### Description
인보이스의 태그를 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**invoiceId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**includedDeleted**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [TagJson](#tagjson) > array|
|**400**|Invalid invoice id supplied|No Content|
|**404**|Invoice not found|No Content|


##### Produces

* `application/json`


<a name="deleteinvoicetags"></a>
#### Remove tags from invoice
```
DELETE /rest/v1/invoices/{invoiceId}/tags
```


##### Description
인보이스의 태그를 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**invoiceId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid invoice id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="deletecba"></a>
#### Delete a CBA item
```
DELETE /rest/v1/invoices/{invoiceId}/{invoiceItemId}/cba
```


##### Description
인보이스의 가상 화폐(cba) 아이템을 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**invoiceId**  <br>*required*|string|
|**Path**|**invoiceItemId**  <br>*required*|string|
|**Query**|**accountId**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid account id, invoice id or invoice item id supplied|No Content|
|**404**|Account or invoice not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="notification_resource"></a>
### Notification

<a name="updatenotificationrule"></a>
#### Update notification rule
```
POST /rest/v1/notification_config
```


##### Description
알림 규칙을 업데이트 한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Body**|**body**  <br>*required*|[NotificationRuleJson](#notificationrulejson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|successful operation|No Content|
|**400**|Invalid Request|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getnotificationrule"></a>
#### Get notification rule
```
GET /rest/v1/notification_config
```


##### Description
알림 규칙을 조회한다.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[NotificationRuleJson](#notificationrulejson)|
|**400**|Invalid Request|No Content|


##### Produces

* `application/json`


<a name="onetimebuy_resource"></a>
### Onetimebuy

<a name="createonetimebuy"></a>
#### Create Onetimebuy
```
POST /rest/v1/onetimebuy
```


##### Description
일회성 구매들을 요청한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Query**|**accountId**  <br>*optional*|string|
|**Query**|**requestedDate**  <br>*optional*|string|
|**Body**|**body**  <br>*required*|[ListOneTimeBuyRequestJson](#listonetimebuyrequestjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|successful operation|< [OneTimeBuyJson](#onetimebuyjson) > array|
|**400**|Invalid Request|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="listonetimebuys"></a>
#### List onetimebuy
```
GET /rest/v1/onetimebuy/pagination
```


##### Description
onetimebuy 를 페이징 하여 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [OneTimeBuyJson](#onetimebuyjson) > array|
|**204**|No Content|No Content|
|**400**|Invalid Request|No Content|


##### Produces

* `application/json`


<a name="searchonetimebuy"></a>
#### Search onetimebuys
```
GET /rest/v1/onetimebuy/search/{searchKey}
```


##### Description
주어진 검색어에 해당하는 onetimebuy 들을 페이징 처리하여 반환한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**searchKey**  <br>*required*|string||
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [OneTimeBuyJson](#onetimebuyjson) > array|
|**204**|No Content|No Content|
|**400**|Invalid Request|No Content|


##### Produces

* `application/json`


<a name="getonetimebuy"></a>
#### Retrieve an onetimebuy by id
```
GET /rest/v1/onetimebuy/{record_id}
```


##### Description
onetimebuy 를 아이디로 조회한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**record_id**  <br>*required*|number|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[OneTimeBuyJson](#onetimebuyjson)|
|**400**|Invalid onetimebuy id supplied|No Content|
|**404**|onetimebuy not found|No Content|


##### Produces

* `application/json`


<a name="cancelonetimebuy"></a>
#### Cancel Onetimebuy
```
DELETE /rest/v1/onetimebuy/{record_id}
```


##### Description
Onetimebuy 요청을 취소한다. 결제 대기(PENDING_INVOICE) 상태인 것만 가능하다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**record_id**  <br>*required*|number|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[OneTimeBuyJson](#onetimebuyjson)|
|**400**|Invalid onetimebuy id supplied|No Content|
|**404**|onetimebuy not found|No Content|


##### Produces

* `application/json`


<a name="organization_resource"></a>
### Organization

<a name="createorganization"></a>
#### Create organization
```
POST /rest/v1/organization
```


##### Description
Organization 을 생성한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Body**|**body**  <br>*required*|[OrganizationJson](#organizationjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|successful operation|No Content|
|**400**|Invalid Request|No Content|
|**409**|Conflict Name|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="listorganization"></a>
#### List organizations
```
GET /rest/v1/organization
```


##### Description
사용자가 소유한 organization 목록을 조회한다.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[OrganizationJson](#organizationjson)|
|**204**|Organization Not Found|No Content|
|**400**|Invalid Request|No Content|


##### Produces

* `application/json`


<a name="getorganizationsales"></a>
#### List organization sales history
```
GET /rest/v1/organization/sales/pagination
```


##### Description
조직의 판매 이력을 페이징 처리하여 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [ProductDistributionHistory](#productdistributionhistory) > array|


##### Produces

* `application/json`


<a name="searchorganizationsales"></a>
#### Search organization sales history
```
GET /rest/v1/organization/sales/search/{searchKey}
```


##### Description
주어진 검색어에 해당하는 조직의 판매 이력을 페이징 처리하여 반환한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**searchKey**  <br>*required*|string||
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [ProductDistributionHistory](#productdistributionhistory) > array|


##### Produces

* `application/json`


<a name="getorganizationsalessummary"></a>
#### get organization sales summary per date
```
GET /rest/v1/organization/sales/summary
```


##### Description
조직의 판매대금 합계를 기간별로 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**end_date**  <br>*optional*|string||
|**Query**|**period**  <br>*optional*|enum (DAY, MONTH, YEAR)|`"DAY"`|
|**Query**|**plan_name**  <br>*optional*|string||
|**Query**|**product_id**  <br>*optional*|string||
|**Query**|**start_date**  <br>*optional*|string||
|**Query**|**usage_name**  <br>*optional*|string||
|**Query**|**vendor_id**  <br>*optional*|string||


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[OrganizationSalesPerDateSummaryJson](#organizationsalesperdatesummaryjson)|
|**400**|Invalid request supplied|No Content|
|**404**|Not found|No Content|


##### Produces

* `application/json`


<a name="getorganization"></a>
#### Retrieve an Organization by id
```
GET /rest/v1/organization/{organizationId}
```


##### Description
organization 을 아이디로 조회한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**organizationId**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[OrganizationJson](#organizationjson)|
|**400**|Invalid organization id supplied|No Content|
|**404**|Organization not found|No Content|


##### Produces

* `application/json`


<a name="updateorganization"></a>
#### Update Organization
```
PUT /rest/v1/organization/{organizationId}
```


##### Description
Organization 정보를 업데이트한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**organizationId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|[OrganizationJson](#organizationjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[OrganizationJson](#organizationjson)|
|**400**|Invalid organization data supplied|No Content|
|**404**|Organization not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="deleteorganization"></a>
#### Remove organization
```
DELETE /rest/v1/organization/{organizationId}
```


##### Description
organization 을 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**organizationId**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|successful operation|No Content|
|**400**|Invalid organization id supplied|No Content|
|**404**|Organization not found|No Content|


##### Produces

* `application/json`


<a name="createorganizationemail"></a>
#### Create organizationEmail
```
POST /rest/v1/organizationEmail
```


##### Description
Organization email 을 생성한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Body**|**body**  <br>*required*|[OrganizationEmailJson](#organizationemailjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|successful operation|No Content|
|**400**|Invalid Request|No Content|
|**409**|Conflict Email|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="listorganizationemail"></a>
#### List organizationEmail
```
GET /rest/v1/organizationEmail
```


##### Description
사용자가 소유한 organization email 목록을 조회한다.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[OrganizationEmailJson](#organizationemailjson)|
|**204**|Organization Not Found|No Content|
|**400**|Invalid Request|No Content|


##### Produces

* `application/json`


<a name="updateorganizationemail"></a>
#### Update Organization Email
```
PUT /rest/v1/organizationEmail/{organizationEmailId}
```


##### Description
Organization Email 정보를 업데이트한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**organizationEmailId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|[OrganizationEmailJson](#organizationemailjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[OrganizationEmailJson](#organizationemailjson)|
|**400**|Invalid organization email data supplied|No Content|
|**404**|Organization email not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="deleteorganizationemail"></a>
#### Remove organization email
```
DELETE /rest/v1/organizationEmail/{organizationEmailId}
```


##### Description
organization email 을 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**organizationEmailId**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|successful operation|No Content|
|**400**|Invalid organization email id supplied|No Content|
|**404**|Organization email not found|No Content|


##### Produces

* `application/json`


<a name="overdue_resource"></a>
### Overdue

<a name="uploadoverdueconfigjson"></a>
#### Upload the full overdue config as JSON
```
POST /rest/v1/overdue
```


##### Description
조직의 연체 규칙을 갱신한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Body**|**body**  <br>*optional*|[OverdueJson](#overduejson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**default**|successful operation|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getoverdueconfigjson"></a>
#### Retrieve the overdue config as JSON
```
GET /rest/v1/overdue
```


##### Description
조직의 연체 규칙을 조회한다.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[OverdueJson](#overduejson)|


##### Produces

* `application/json`


<a name="paymentmethods_resource"></a>
### PaymentMethods

<a name="getpaymentmethodbykey"></a>
#### Retrieve a payment method by external key
```
GET /rest/v1/paymentMethods
```


##### Description
external key 로 결제 수단을 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**externalKey**  <br>*optional*|string||
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[PaymentMethodJson](#paymentmethodjson)|
|**404**|Account or payment method not found|No Content|


##### Produces

* `application/json`


<a name="getpaymentmethods"></a>
#### List payment methods
```
GET /rest/v1/paymentMethods/pagination
```


##### Description
결제 수단을 페이징 하여 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|
|**Query**|**pluginName**  <br>*optional*|string||
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [PaymentMethodJson](#paymentmethodjson) > array|


##### Produces

* `application/json`


<a name="searchpaymentmethods"></a>
#### Search payment methods
```
GET /rest/v1/paymentMethods/search/{searchKey}
```


##### Description
주어진 검색어로 결제 수단을 페이징 하여 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**searchKey**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|
|**Query**|**pluginName**  <br>*optional*|string||
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [PaymentMethodJson](#paymentmethodjson) > array|


##### Produces

* `application/json`


<a name="getpaymentmethod"></a>
#### Retrieve a payment method by id
```
GET /rest/v1/paymentMethods/{paymentMethodId}
```


##### Description
아이디로 결제 수단을 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**paymentMethodId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[PaymentMethodJson](#paymentmethodjson)|
|**400**|Invalid paymentMethodId supplied|No Content|
|**404**|Account or payment method not found|No Content|


##### Produces

* `application/json`


<a name="deletepaymentmethod"></a>
#### Delete a payment method
```
DELETE /rest/v1/paymentMethods/{paymentMethodId}
```


##### Description
결제 수단을 삭제한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string||
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string||
|**Header**|**X-Killbill-Reason**  <br>*optional*|string||
|**Path**|**paymentMethodId**  <br>*required*|string||
|**Query**|**deleteDefaultPmWithAutoPayOff**  <br>*optional*|boolean|`"false"`|
|**Query**|**forceDefaultPmDeletion**  <br>*optional*|boolean|`"false"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid paymentMethodId supplied|No Content|
|**404**|Account or payment method not found|No Content|


##### Produces

* `application/json`


<a name="createpaymentmethodcustomfields"></a>
#### Add custom fields to payment method
```
POST /rest/v1/paymentMethods/{paymentMethodId}/customFields
```


##### Description
결제 수단에 커스텀 필드를 추가한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentMethodId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|< [CustomFieldJson](#customfieldjson) > array|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment method id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getpaymentmethodcustomfields"></a>
#### Retrieve payment method custom fields
```
GET /rest/v1/paymentMethods/{paymentMethodId}/customFields
```


##### Description
결제 수단의 커스텀 필드를 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**paymentMethodId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [CustomFieldJson](#customfieldjson) > array|
|**400**|Invalid payment method id supplied|No Content|


##### Produces

* `application/json`


<a name="deletepaymentmethodcustomfields"></a>
#### Remove custom fields from payment method
```
DELETE /rest/v1/paymentMethods/{paymentMethodId}/customFields
```


##### Description
결제 수단의 커스텀 필드를 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentMethodId**  <br>*required*|string|
|**Query**|**customFieldList**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment method id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="paymenttransactions_resource"></a>
### PaymentTransactions

<a name="notifystatechanged"></a>
#### Mark a pending payment transaction as succeeded or failed
```
POST /rest/v1/paymentTransactions/{transactionId}
```


##### Description
Pending 상태인 결제 트랜잭션을 succeeded 또는 failed 상태로 변경한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**transactionId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid paymentId supplied|No Content|
|**404**|Account or Payment not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="createpaymenttransactioncustomfields"></a>
#### Add custom fields to payment transaction
```
POST /rest/v1/paymentTransactions/{transactionId}/customFields
```


##### Description
결제 트랜잭션에 커스텀 필드를 추가한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**transactionId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|< [CustomFieldJson](#customfieldjson) > array|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid transaction id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getpaymenttransactioncustomfields"></a>
#### Retrieve payment transaction custom fields
```
GET /rest/v1/paymentTransactions/{transactionId}/customFields
```


##### Description
결제 트랜잭션의 커스텀 필드를 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**transactionId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [CustomFieldJson](#customfieldjson) > array|
|**400**|Invalid transaction id supplied|No Content|


##### Produces

* `application/json`


<a name="deletepaymenttransactioncustomfields"></a>
#### Remove custom fields from payment transaction
```
DELETE /rest/v1/paymentTransactions/{transactionId}/customFields
```


##### Description
결제 트랜잭션의 커스텀 필드를 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**transactionId**  <br>*required*|string|
|**Query**|**customFieldList**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid transaction id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="createpaymenttransactiontags"></a>
#### Add tags to payment transaction
```
POST /rest/v1/paymentTransactions/{transactionId}/tags
```


##### Description
결제 트랜잭션에 태그를 추가한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**transactionId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid transaction id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getpaymenttransactiontags"></a>
#### Retrieve payment transaction tags
```
GET /rest/v1/paymentTransactions/{transactionId}/tags
```


##### Description
결제 트랜잭션의 태그를 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**transactionId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**includedDeleted**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [TagJson](#tagjson) > array|
|**400**|Invalid transaction id supplied|No Content|
|**404**|Invoice not found|No Content|


##### Produces

* `application/json`


<a name="deletepaymenttransactiontags"></a>
#### Remove tags from payment transaction
```
DELETE /rest/v1/paymentTransactions/{transactionId}/tags
```


##### Description
결제 트랜잭션에 태그를 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**transactionId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid transaction id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="payments_resource"></a>
### Payments

<a name="captureauthorizationbyexternalkey"></a>
#### Capture an existing authorization
```
POST /rest/v1/payments
```


##### Description
paymentExternalKey 사용. PG 사를 통해 Authorization (결제 승인 대기) 중인 결제 이력에 대해, 결제 확인을 한다. 이후 PG 사에서 판매자(조직) 의 구좌에 입금처리가 완료된다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|Payment transaction created successfully|No Content|
|**402**|Transaction declined by gateway|No Content|
|**404**|Account or payment not found|No Content|
|**422**|Payment is aborted by a control plugin|No Content|
|**502**|Failed to submit payment transaction|No Content|
|**503**|Payment in unknown status, failed to receive gateway response|No Content|
|**504**|Payment operation timeout|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getpaymentbyexternalkey"></a>
#### Retrieve a payment by external key
```
GET /rest/v1/payments
```


##### Description
external key 로 결제 이력을 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**externalKey**  <br>*optional*|string||
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**withAttempts**  <br>*optional*|boolean|`"false"`|
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[PaymentJson](#paymentjson)|
|**404**|Payment not found|No Content|


##### Produces

* `application/json`


<a name="completetransactionbyexternalkey"></a>
#### Complete an existing transaction
```
PUT /rest/v1/payments
```


##### Description
paymentExternalKey 사용. 결제 트랜잭션을 Complete 상태로 전환한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|Payment transaction created successfully|No Content|
|**402**|Transaction declined by gateway|No Content|
|**404**|Account or payment not found|No Content|
|**422**|Payment is aborted by a control plugin|No Content|
|**502**|Failed to submit payment transaction|No Content|
|**503**|Payment in unknown status, failed to receive gateway response|No Content|
|**504**|Payment operation timeout|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="voidpaymentbyexternalkey"></a>
#### Void an existing payment
```
DELETE /rest/v1/payments
```


##### Description
paymentExternalKey 사용. PG 사를 통해 Authorization (결제 승인 대기) 중인 결제 이력에 대해 결제 취소를 한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|Payment transaction created successfully|No Content|
|**402**|Transaction declined by gateway|No Content|
|**404**|Account or payment not found|No Content|
|**422**|Payment is aborted by a control plugin|No Content|
|**502**|Failed to submit payment transaction|No Content|
|**503**|Payment in unknown status, failed to receive gateway response|No Content|
|**504**|Payment operation timeout|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="cancelscheduledpaymenttransactionbyexternalkey"></a>
#### Cancels a scheduled payment attempt retry
```
DELETE /rest/v1/payments/cancelScheduledPaymentTransaction
```


##### Description
transactionExternalKey 사용. 결제 재시도 예약중인 결제 트랜잭션을 예약취소 시킨다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Query**|**transactionExternalKey**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid paymentTransactionExternalKey supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="chargebackreversalpaymentbyexternalkey"></a>
#### Record a chargeback reversal
```
POST /rest/v1/payments/chargebackReversals
```


##### Description
paymentExternalKey 사용. 결제이력의 chargeback(지불 거절) 요청을 취소한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|Payment transaction created successfully|No Content|
|**402**|Transaction declined by gateway|No Content|
|**404**|Account or payment not found|No Content|
|**422**|Payment is aborted by a control plugin|No Content|
|**502**|Failed to submit payment transaction|No Content|
|**503**|Payment in unknown status, failed to receive gateway response|No Content|
|**504**|Payment operation timeout|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="chargebackpaymentbyexternalkey"></a>
#### Record a chargeback
```
POST /rest/v1/payments/chargebacks
```


##### Description
paymentExternalKey 사용. 결제이력에 대해 chargeback(지불 거절) 요청을 한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|Payment transaction created successfully|No Content|
|**402**|Transaction declined by gateway|No Content|
|**404**|Account or payment not found|No Content|
|**422**|Payment is aborted by a control plugin|No Content|
|**502**|Failed to submit payment transaction|No Content|
|**503**|Payment in unknown status, failed to receive gateway response|No Content|
|**504**|Payment operation timeout|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="createcombopayment"></a>
#### Combo api to create a new payment transaction on a existing (or not) account 
```
POST /rest/v1/payments/combo
```


##### Description
구매자 생성과 결제 수단 등록, 결제 트랜잭션 생성을 한번에 진행할 수 있도록 한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[ComboPaymentTransactionJson](#combopaymenttransactionjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|Payment transaction created successfully|No Content|
|**400**|Invalid data for Account or PaymentMethod|No Content|
|**402**|Transaction declined by gateway|No Content|
|**422**|Payment is aborted by a control plugin|No Content|
|**502**|Failed to submit payment transaction|No Content|
|**503**|Payment in unknown status, failed to receive gateway response|No Content|
|**504**|Payment operation timeout|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getpayments"></a>
#### Get payments
```
GET /rest/v1/payments/pagination
```


##### Description
결제 이력을 페이징 하여 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|
|**Query**|**pluginName**  <br>*optional*|string||
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**withAttempts**  <br>*optional*|boolean|`"false"`|
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [PaymentJson](#paymentjson) > array|


##### Produces

* `application/json`


<a name="refundpaymentbyexternalkey"></a>
#### Refund an existing payment
```
POST /rest/v1/payments/refunds
```


##### Description
paymentExternalKey 사용. 결제 이력에 대해 환불 처리한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|Payment transaction created successfully|No Content|
|**402**|Transaction declined by gateway|No Content|
|**404**|Account or payment not found|No Content|
|**422**|Payment is aborted by a control plugin|No Content|
|**502**|Failed to submit payment transaction|No Content|
|**503**|Payment in unknown status, failed to receive gateway response|No Content|
|**504**|Payment operation timeout|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="searchpayments"></a>
#### Search payments
```
GET /rest/v1/payments/search/{searchKey}
```


##### Description
주어진 검색어로 결제 이력을 페이징 하여 조회한다.


##### Parameters

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


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [PaymentJson](#paymentjson) > array|


##### Produces

* `application/json`


<a name="captureauthorization"></a>
#### Capture an existing authorization
```
POST /rest/v1/payments/{paymentId}
```


##### Description
PG 사를 통해 Authorization (결제 승인 대기) 중인 결제 이력에 대해, 결제 확인을 한다. 이후 PG 사에서 판매자(조직) 의 구좌에 입금처리가 완료된다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


##### Responses

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


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getpayment"></a>
#### Retrieve a payment by id
```
GET /rest/v1/payments/{paymentId}
```


##### Description
아이디로 결제 이력을 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**paymentId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)||
|**Query**|**withAttempts**  <br>*optional*|boolean|`"false"`|
|**Query**|**withPluginInfo**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[PaymentJson](#paymentjson)|
|**400**|Invalid paymentId supplied|No Content|
|**404**|Payment not found|No Content|


##### Produces

* `application/json`


<a name="completetransaction"></a>
#### Complete an existing transaction
```
PUT /rest/v1/payments/{paymentId}
```


##### Description
결제 트랜잭션을 Complete 처리 한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


##### Responses

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


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="voidpayment"></a>
#### Void an existing payment
```
DELETE /rest/v1/payments/{paymentId}
```


##### Description
PG 사를 통해 Authorization (결제 승인 대기) 중인 결제 이력에 대해, 결제 취소를 한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


##### Responses

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


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="chargebackreversalpayment"></a>
#### Record a chargeback reversal
```
POST /rest/v1/payments/{paymentId}/chargebackReversals
```


##### Description
결제이력의 chargeback(지불 거절) 요청을 취소한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


##### Responses

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


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="chargebackpayment"></a>
#### Record a chargeback
```
POST /rest/v1/payments/{paymentId}/chargebacks
```


##### Description
결제이력에 chargeback(지불 거절) 요청을 한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


##### Responses

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


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="createpaymentcustomfields"></a>
#### Add custom fields to payment
```
POST /rest/v1/payments/{paymentId}/customFields
```


##### Description
결제 이력에 커스텀 필드를 추가한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|< [CustomFieldJson](#customfieldjson) > array|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getpaymentcustomfields"></a>
#### Retrieve payment custom fields
```
GET /rest/v1/payments/{paymentId}/customFields
```


##### Description
결제 이력의 커스텀 필드를 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**paymentId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [CustomFieldJson](#customfieldjson) > array|
|**400**|Invalid payment id supplied|No Content|


##### Produces

* `application/json`


<a name="deletepaymentcustomfields"></a>
#### Remove custom fields from payment
```
DELETE /rest/v1/payments/{paymentId}/customFields
```


##### Description
결제 이력의 커스텀 필드를 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**customFieldList**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="refundpayment"></a>
#### Refund an existing payment
```
POST /rest/v1/payments/{paymentId}/refunds
```


##### Description
결제이력에 대해 환불처리를 한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**controlPluginName**  <br>*optional*|< string > array(multi)|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Body**|**body**  <br>*optional*|[PaymentTransactionJson](#paymenttransactionjson)|


##### Responses

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


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="createpaymenttags"></a>
#### Add tags to payment
```
POST /rest/v1/payments/{paymentId}/tags
```


##### Description
결제 이력에 태그를 추가한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getpaymenttags"></a>
#### Retrieve payment payment tags
```
GET /rest/v1/payments/{paymentId}/tags
```


##### Description
결제 이력의 태그를 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**paymentId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**includedDeleted**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [TagJson](#tagjson) > array|
|**400**|Invalid payment id supplied|No Content|
|**404**|Invoice not found|No Content|


##### Produces

* `application/json`


<a name="deletepaymenttags"></a>
#### Remove tags from payment
```
DELETE /rest/v1/payments/{paymentId}/tags
```


##### Description
결제 이력의 태그를 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid payment id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="cancelscheduledpaymenttransactionbyid"></a>
#### Cancels a scheduled payment attempt retry
```
DELETE /rest/v1/payments/{paymentTransactionId}/cancelScheduledPaymentTransaction
```


##### Description
결제 재시도 예약중인 결제 트랜잭션을 예약취소 시킨다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**paymentTransactionId**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid paymentTransactionId supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="pluginsinfo_resource"></a>
### PluginsInfo

<a name="product_resource"></a>
### Product

<a name="createproduct"></a>
#### Create product
```
POST /rest/v1/product
```


##### Description
Product 을 생성한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Body**|**body**  <br>*required*|[ProductJson](#productjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|successful operation|No Content|
|**400**|Invalid Request|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="listproducts"></a>
#### List products
```
GET /rest/v1/product/pagination
```


##### Description
product 를 페이징 하여 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**category**  <br>*optional*|enum (BASE, ADD_ON)||
|**Query**|**is_active**  <br>*optional*|enum (Y, N)||
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [ProductJson](#productjson) > array|
|**204**|No Content|No Content|
|**400**|Invalid Request|No Content|


##### Produces

* `application/json`


<a name="searchproduct"></a>
#### Search products
```
GET /rest/v1/product/search/{searchKey}
```


##### Description
주어진 검색어에 해당하는 product 들을 페이징 처리하여 반환한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**searchKey**  <br>*required*|string||
|**Query**|**category**  <br>*optional*|enum (BASE, ADD_ON)||
|**Query**|**is_active**  <br>*optional*|enum (Y, N)||
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [ProductJson](#productjson) > array|
|**204**|No Content|No Content|
|**400**|Invalid Request|No Content|


##### Produces

* `application/json`


<a name="getproduct"></a>
#### Retrieve an product by id
```
GET /rest/v1/product/{productId}
```


##### Description
product 을 아이디로 조회한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**productId**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[ProductJson](#productjson)|
|**400**|Invalid product id supplied|No Content|
|**404**|product not found|No Content|


##### Produces

* `application/json`


<a name="updateproduct"></a>
#### Update product
```
PUT /rest/v1/product/{productId}
```


##### Description
product 정보를 업데이트한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**productId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|[ProductJson](#productjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[ProductJson](#productjson)|
|**400**|Invalid product data supplied|No Content|
|**404**|product not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="deleteproduct"></a>
#### Remove product
```
DELETE /rest/v1/product/{productId}
```


##### Description
product 을 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**productId**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|successful operation|No Content|
|**400**|Invalid product id supplied|No Content|
|**404**|product not found|No Content|


##### Produces

* `application/json`


<a name="updateproductactive"></a>
#### Set product active
```
PUT /rest/v1/product/{productId}/active
```


##### Description
product 의 active 여부를 결정한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**productId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|[ProductJson](#productjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[ProductJson](#productjson)|
|**400**|Invalid product data supplied|No Content|
|**404**|product not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getaccountssales"></a>
#### List product sales history
```
GET /rest/v1/product/{productId}/sales/pagination
```


##### Description
제품의 판매 이력을 페이징 처리하여 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**productId**  <br>*required*|string||
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [ProductDistributionHistory](#productdistributionhistory) > array|


##### Produces

* `application/json`


<a name="searchaccountssales"></a>
#### Search product sales history
```
GET /rest/v1/product/{productId}/sales/search/{searchKey}
```


##### Description
주어진 검색어에 해당하는 제품 판매 이력을 페이징 처리하여 반환한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**productId**  <br>*required*|string||
|**Path**|**searchKey**  <br>*required*|string||
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [ProductDistributionHistory](#productdistributionhistory) > array|


##### Produces

* `application/json`


<a name="getproductsalessummary"></a>
#### get product sales summary per date
```
GET /rest/v1/product/{productId}/sales/summary
```


##### Description
제품의 판매대금 합계를 기간별로 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**productId**  <br>*required*|string||
|**Query**|**end_date**  <br>*optional*|string||
|**Query**|**period**  <br>*optional*|enum (DAY, MONTH, YEAR)|`"DAY"`|
|**Query**|**plan_name**  <br>*optional*|string||
|**Query**|**start_date**  <br>*optional*|string||
|**Query**|**usage_name**  <br>*optional*|string||
|**Query**|**vendor_id**  <br>*optional*|string||


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[SalesPerDateSummaryJson](#salesperdatesummaryjson)|
|**400**|Invalid account id supplied|No Content|
|**404**|Product not found|No Content|


##### Produces

* `application/json`


<a name="createproductversion"></a>
#### Create product version
```
POST /rest/v1/product/{productId}/version
```


##### Description
Product Version 을 생성한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**productId**  <br>*required*|string|
|**Body**|**body**  <br>*required*|[ProductVersionJson](#productversionjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|successful operation|No Content|
|**400**|Invalid Request|No Content|
|**404**|product not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="listproductversions"></a>
#### List Product Version
```
GET /rest/v1/product/{productId}/version
```


##### Description
product 의 모든 version 을 조회한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**productId**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [ProductVersionJson](#productversionjson) > array|
|**400**|Invalid product id supplied|No Content|
|**404**|product not found|No Content|


##### Produces

* `application/json`


<a name="getcurrentproductversion"></a>
#### Retrieve an current product version
```
GET /rest/v1/product/{productId}/version/current
```


##### Description
product 의 현재 시각 적용 version 을 조회한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**productId**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[ProductVersionJson](#productversionjson)|
|**400**|Invalid product version supplied|No Content|
|**404**|product version not found|No Content|


##### Produces

* `application/json`


<a name="getproductversion"></a>
#### Retrieve an product version by version
```
GET /rest/v1/product/{productId}/version/{version}
```


##### Description
product 의 version 을 조회한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**productId**  <br>*required*|string|
|**Path**|**version**  <br>*required*|number|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[ProductVersionJson](#productversionjson)|
|**400**|Invalid product version supplied|No Content|
|**404**|product version not found|No Content|


##### Produces

* `application/json`


<a name="updateproductversion"></a>
#### Update product version
```
PUT /rest/v1/product/{productId}/version/{version}
```


##### Description
product version 정보를 업데이트한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**productId**  <br>*required*|string|
|**Path**|**version**  <br>*required*|number|
|**Body**|**body**  <br>*optional*|[ProductVersionJson](#productversionjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[ProductVersionJson](#productversionjson)|
|**400**|Invalid product version data supplied|No Content|
|**404**|product version not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="deleteproductversion"></a>
#### Remove product version
```
DELETE /rest/v1/product/{productId}/version/{version}
```


##### Description
product version 을 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**productId**  <br>*required*|string|
|**Path**|**version**  <br>*required*|number|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|successful operation|No Content|
|**400**|Invalid product version supplied|No Content|
|**404**|product version not found|No Content|


##### Produces

* `application/json`


<a name="retry_resource"></a>
### Retry

<a name="updateretryrule"></a>
#### Update retry rule
```
POST /rest/v1/retry
```


##### Description
결제 재시도 규칙을 업데이트 한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Body**|**body**  <br>*required*|[RetryRuleJson](#retryrulejson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|successful operation|No Content|
|**400**|Invalid Request|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getretryrule"></a>
#### Get retry rule
```
GET /rest/v1/retry
```


##### Description
결제 재시도 규칙을 조회한다.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[RetryRuleJson](#retryrulejson)|
|**400**|Invalid Request|No Content|


##### Produces

* `application/json`


<a name="rule_resource"></a>
### Rule

<a name="updatebillingrule"></a>
#### Update billing rule
```
POST /rest/v1/rule
```


##### Description
빌링 규칙을 업데이트 한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Body**|**body**  <br>*required*|[BillingRuleJson](#billingrulejson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|successful operation|No Content|
|**400**|Invalid Request|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getbillingrule"></a>
#### Get billing rule
```
GET /rest/v1/rule
```


##### Description
빌링 규칙을 조회한다.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[BillingRuleJson](#billingrulejson)|
|**400**|Invalid Request|No Content|


##### Produces

* `application/json`


<a name="subscriptions_resource"></a>
### Subscriptions

<a name="createentitlement"></a>
#### Create an entitlement
```
POST /rest/v1/subscriptions
```


##### Description
BASE 또는 ADD_ON 구독을 생성한다.


##### Parameters

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


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid entitlement supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="createentitlementwithaddons"></a>
#### Create an entitlement with addOn products
```
POST /rest/v1/subscriptions/createEntitlementWithAddOns
```


##### Description
ADD_ON 구독이 포함된 BASE 구독을 생성한다.


##### Parameters

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


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid entitlement supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="createentitlementswithaddons"></a>
#### Create multiple entitlements with addOn products
```
POST /rest/v1/subscriptions/createEntitlementsWithAddOns
```


##### Description
ADD_ON 구독이 포함된 BASE 구독을 다수 생성한다.


##### Parameters

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


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid entitlements supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getentitlement"></a>
#### Retrieve a subscription by id
```
GET /rest/v1/subscriptions/{subscriptionId}
```


##### Description
아이디로 구독을 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**subscriptionId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[SubscriptionJson](#subscriptionjson)|
|**400**|Invalid subscription id supplied|No Content|
|**404**|Subscription not found|No Content|


##### Produces

* `application/json`


<a name="changeentitlementplan"></a>
#### Change entitlement plan
```
PUT /rest/v1/subscriptions/{subscriptionId}
```


##### Description
구독의 플랜을 변경한다.


##### Parameters

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


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid subscription id supplied|No Content|
|**404**|Entitlement not found|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="cancelentitlementplan"></a>
#### Cancel an entitlement plan
```
DELETE /rest/v1/subscriptions/{subscriptionId}
```


##### Description
구독을 취소(cancel) 한다. 취소된 구독은 완전히 종료된 것으로 재시작 할 수 없다.


##### Parameters

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


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid subscription id supplied|No Content|
|**404**|Entitlement not found|No Content|


##### Produces

* `application/json`


<a name="updatesubscriptionbcd"></a>
#### Update the BCD associated to a subscription
```
PUT /rest/v1/subscriptions/{subscriptionId}/bcd
```


##### Description
구독의 결제 주기 날짜를 변경한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**subscriptionId**  <br>*required*|string|
|**Query**|**effectiveFromDate**  <br>*optional*|string|
|**Body**|**body**  <br>*optional*|[SubscriptionJson](#subscriptionjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid entitlement supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="addsubscriptionblockingstate"></a>
#### Block a subscription
```
PUT /rest/v1/subscriptions/{subscriptionId}/block
```


##### Description
구독의 Block 상태를 설정한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**subscriptionId**  <br>*required*|string|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|
|**Query**|**requestedDate**  <br>*optional*|string|
|**Body**|**body**  <br>*optional*|[BlockingStateJson](#blockingstatejson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid subscription id supplied|No Content|
|**404**|Subscription not found|No Content|


##### Consumes

* `application/json`


<a name="createsubscriptioncustomfields"></a>
#### Add custom fields to subscription
```
POST /rest/v1/subscriptions/{subscriptionId}/customFields
```


##### Description
구독에 커스텀 필드를 추가한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**subscriptionId**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|< [CustomFieldJson](#customfieldjson) > array|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid subscription id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getsubscriptioncustomfields"></a>
#### Retrieve subscription custom fields
```
GET /rest/v1/subscriptions/{subscriptionId}/customFields
```


##### Description
구독의 커스텀 필드를 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**subscriptionId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [CustomFieldJson](#customfieldjson) > array|
|**400**|Invalid subscription id supplied|No Content|


##### Produces

* `application/json`


<a name="deletesubscriptioncustomfields"></a>
#### Remove custom fields from subscription
```
DELETE /rest/v1/subscriptions/{subscriptionId}/customFields
```


##### Description
구독에 커스텀 필드를 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**subscriptionId**  <br>*required*|string|
|**Query**|**customFieldList**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid subscription id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="createsubscriptiontags"></a>
#### Add tags to subscription
```
POST /rest/v1/subscriptions/{subscriptionId}/tags
```


##### Description
구독에 태그를 추가하다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**subscriptionId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid subscription id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getsubscriptiontags"></a>
#### Retrieve subscription tags
```
GET /rest/v1/subscriptions/{subscriptionId}/tags
```


##### Description
구독의 태그를 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**subscriptionId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**includedDeleted**  <br>*optional*|boolean|`"false"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [TagJson](#tagjson) > array|
|**400**|Invalid subscription id supplied|No Content|
|**404**|Subscription not found|No Content|


##### Produces

* `application/json`


<a name="deletesubscriptiontags"></a>
#### Remove tags from subscription
```
DELETE /rest/v1/subscriptions/{subscriptionId}/tags
```


##### Description
구독에 태그를 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**subscriptionId**  <br>*required*|string|
|**Query**|**tagList**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid subscription id supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="uncancelentitlementplan"></a>
#### Un-cancel an entitlement
```
PUT /rest/v1/subscriptions/{subscriptionId}/uncancel
```


##### Description
구독 중단(cancel) 요청 예약 상태일때, 예약일이 당도하지 않았다면, 구독 중단 예약을 취소할 수 있다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**subscriptionId**  <br>*required*|string|
|**Query**|**pluginProperty**  <br>*optional*|< string > array(multi)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid subscription id supplied|No Content|
|**404**|Entitlement not found|No Content|


##### Produces

* `application/json`


<a name="tagdefinitions_resource"></a>
### TagDefinitions

<a name="createtagdefinition"></a>
#### Create a tag definition
```
POST /rest/v1/tagDefinitions
```


##### Description
태그 정의를 추가한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Body**|**body**  <br>*optional*|[TagDefinitionJson](#tagdefinitionjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid name or description supplied|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="gettagdefinitions"></a>
#### List tag definitions
```
GET /rest/v1/tagDefinitions
```


##### Description
태그 정의 목록을 조회한다. 이 목록에는 빌링 시스템에서 쓰이는 필수 태그 및 사용자 정의 태그들이 포함된다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [TagDefinitionJson](#tagdefinitionjson) > array|


##### Produces

* `application/json`


<a name="gettagdefinition"></a>
#### Retrieve a tag definition
```
GET /rest/v1/tagDefinitions/{tagDefinitionId}
```


##### Description
아이디로 태그 정의를 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**tagDefinitionId**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TagDefinitionJson](#tagdefinitionjson)|
|**400**|Invalid tagDefinitionId supplied|No Content|


##### Produces

* `application/json`


<a name="deletetagdefinition"></a>
#### Delete a tag definition
```
DELETE /rest/v1/tagDefinitions/{tagDefinitionId}
```


##### Description
태그 정의를 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**tagDefinitionId**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid tagDefinitionId supplied|No Content|


##### Produces

* `application/json`


<a name="tags_resource"></a>
### Tags

<a name="gettags"></a>
#### List tags
```
GET /rest/v1/tags/pagination
```


##### Description
태그를 페이징하여 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [TagJson](#tagjson) > array|


##### Produces

* `application/json`


<a name="searchtags"></a>
#### Search tags
```
GET /rest/v1/tags/search/{searchKey}
```


##### Description
주어진 검색어로 태그를 페이징 하여 조회한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Path**|**searchKey**  <br>*required*|string||
|**Query**|**audit**  <br>*optional*|string|`"NONE"`|
|**Query**|**limit**  <br>*optional*|integer (int64)|`100`|
|**Query**|**offset**  <br>*optional*|integer (int64)|`0`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|< [TagJson](#tagjson) > array|


##### Produces

* `application/json`


<a name="template_resource"></a>
### Template

<a name="getalltemplates"></a>
#### List notification templates
```
GET /rest/v1/template
```


##### Description
Notification template 목록을 조회한다.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TemplatePerNotificationJson](#templatepernotificationjson)|
|**400**|Invalid Request|No Content|


##### Produces

* `application/json`


<a name="gettemplatebytype"></a>
#### Retrieve an template by notificationType
```
GET /rest/v1/template/{notificationType}
```


##### Description
notificationType 별로 template 을 조회한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**notificationType**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TemplatePerNotificationJson](#templatepernotificationjson)|
|**400**|Invalid notificationType supplied|No Content|


##### Produces

* `application/json`


<a name="deletetemplatebytype"></a>
#### Remove template by notificationType
```
DELETE /rest/v1/template/{notificationType}
```


##### Description
notificationType 의 template 을 모두 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**notificationType**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|successful operation|No Content|
|**400**|Invalid notificationType supplied|No Content|


##### Produces

* `application/json`


<a name="createtemplate"></a>
#### Upload template by notificationType and locale
```
POST /rest/v1/template/{notificationType}/{locale}
```


##### Description
notificationType 과 locale 에 해당하는 template 을 업로드한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**locale**  <br>*required*|string|
|**Path**|**notificationType**  <br>*required*|string|
|**Body**|**body**  <br>*required*|[TemplateJson](#templatejson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**201**|successful operation|No Content|
|**400**|Invalid Request|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="gettemplatebytypeandlocale"></a>
#### Retrieve an template by notificationType and locale
```
GET /rest/v1/template/{notificationType}/{locale}
```


##### Description
notificationType 과 locale 에 해당하는 template 을 조회한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**locale**  <br>*required*|string|
|**Path**|**notificationType**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TemplateJson](#templatejson)|
|**400**|Invalid notificationType and locale supplied|No Content|
|**404**|template not found|No Content|


##### Produces

* `application/json`


<a name="setdefaulttemplate"></a>
#### Set default template by notificationType and locale
```
PUT /rest/v1/template/{notificationType}/{locale}
```


##### Description
notificationType 과 locale 에 해당하는 template 을 default template 으로 지정한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**locale**  <br>*required*|string|
|**Path**|**notificationType**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TemplateJson](#templatejson)|
|**400**|Invalid notificationType and locale supplied|No Content|
|**404**|template not found|No Content|


##### Produces

* `application/json`


<a name="deletetemplatebytypeandlocale"></a>
#### Remove template by notificationType and locale
```
DELETE /rest/v1/template/{notificationType}/{locale}
```


##### Description
notificationType 과 locale 에 해당하는 template 을 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**locale**  <br>*required*|string|
|**Path**|**notificationType**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**204**|successful operation|No Content|
|**400**|Invalid notificationType and locale supplied|No Content|
|**404**|template not found|No Content|


##### Produces

* `application/json`


<a name="tenants_resource"></a>
### Tenants

<a name="gettenantbyapikey"></a>
#### Retrieve a tenant by its API key
```
GET /rest/v1/tenants
```


##### Description
api key 로 테넌트를 조회한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Query**|**apiKey**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TenantJson](#tenantjson)|
|**404**|Tenant not found|No Content|


##### Produces

* `application/json`


<a name="uploadpertenantconfiguration"></a>
#### Add a per tenant configuration (system properties)
```
POST /rest/v1/tenants/uploadPerTenantConfig
```


##### Description
테넌트 고유 시스템 프로퍼티를 추가한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Body**|**body**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid tenantId supplied|No Content|


##### Consumes

* `text/plain`


##### Produces

* `application/json`


<a name="getpertenantconfiguration"></a>
#### Retrieve a per tenant configuration (system properties)
```
GET /rest/v1/tenants/uploadPerTenantConfig
```


##### Description
테넌트 고유 시스템 프로퍼티를 조회한다.


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TenantKeyJson](#tenantkeyjson)|
|**400**|Invalid tenantId supplied|No Content|


##### Produces

* `application/json`


<a name="deletepertenantconfiguration"></a>
#### Delete a per tenant configuration (system properties)
```
DELETE /rest/v1/tenants/uploadPerTenantConfig
```


##### Description
테넌트 고유 시스템 프로퍼티를 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid tenantId supplied|No Content|


<a name="getallpluginconfiguration"></a>
#### Retrieve a per tenant key value based on key prefix
```
GET /rest/v1/tenants/uploadPerTenantConfig/{keyPrefix}/search
```


##### Description
주어진 프로퍼티 키에 해당하는 테넌트 고유 시스템 프로퍼티를 조회한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**keyPrefix**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TenantKeyJson](#tenantkeyjson)|
|**400**|Invalid tenantId supplied|No Content|


##### Produces

* `application/json`


<a name="uploadpluginconfiguration"></a>
#### Add a per tenant configuration for a plugin
```
POST /rest/v1/tenants/uploadPluginConfig/{pluginName}
```


##### Description
테넌트 플러그인 설정값을 추가한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**pluginName**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid tenantId supplied|No Content|


##### Consumes

* `text/plain`


##### Produces

* `application/json`


<a name="getpluginconfiguration"></a>
#### Retrieve a per tenant configuration for a plugin
```
GET /rest/v1/tenants/uploadPluginConfig/{pluginName}
```


##### Description
테넌트 플러그인 설정값을 조회한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**pluginName**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TenantKeyJson](#tenantkeyjson)|
|**400**|Invalid tenantId supplied|No Content|


##### Produces

* `application/json`


<a name="deletepluginconfiguration"></a>
#### Delete a per tenant configuration for a plugin
```
DELETE /rest/v1/tenants/uploadPluginConfig/{pluginName}
```


##### Description
테넌트 플러그인 설정값을 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**pluginName**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid tenantId supplied|No Content|


<a name="insertuserkeyvalue"></a>
#### Add a per tenant user key/value
```
POST /rest/v1/tenants/userKeyValue/{keyName}
```


##### Description
테넌트의 사용자 key value 를 추가한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**keyName**  <br>*required*|string|
|**Body**|**body**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid tenantId supplied|No Content|


##### Consumes

* `text/plain`


##### Produces

* `application/json`


<a name="getuserkeyvalue"></a>
#### Retrieve a per tenant user key/value
```
GET /rest/v1/tenants/userKeyValue/{keyName}
```


##### Description
테넌트의 사용자 key value 를 조회한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**keyName**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TenantKeyJson](#tenantkeyjson)|
|**400**|Invalid tenantId supplied|No Content|


##### Produces

* `application/json`


<a name="deleteuserkeyvalue"></a>
#### Delete  a per tenant user key/value
```
DELETE /rest/v1/tenants/userKeyValue/{keyName}
```


##### Description
테넌트의 사용자 key value 를 삭제한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Path**|**keyName**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid tenantId supplied|No Content|


<a name="gettenant"></a>
#### Retrieve a tenant by id
```
GET /rest/v1/tenants/{tenantId}
```


##### Description
아이디로 테넌트를 조회한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**tenantId**  <br>*required*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[TenantJson](#tenantjson)|
|**400**|Invalid tenantId supplied|No Content|
|**404**|Tenant not found|No Content|


##### Produces

* `application/json`


<a name="test_resource"></a>
### Test

<a name="settestclocktime"></a>
#### Set the current time
```
POST /rest/v1/test/clock
```


##### Description
빌링 시스템의 현재 시각을 설정한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**requestedDate**  <br>*optional*|string||
|**Query**|**timeZone**  <br>*optional*|string||
|**Query**|**timeoutSec**  <br>*optional*|integer (int64)|`5`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[ClockResource](#clockresource)|
|**400**|Invalid time or timezone supplied|No Content|


##### Produces

* `application/json`


<a name="getcurrenttime"></a>
#### Get the current time
```
GET /rest/v1/test/clock
```


##### Description
빌링 시스템의 현재 시각을 조회한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Query**|**timeZone**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[ClockResource](#clockresource)|
|**400**|Invalid timezone supplied|No Content|


##### Produces

* `application/json`


<a name="updatetestclocktime"></a>
#### Move the current time
```
PUT /rest/v1/test/clock
```


##### Description
빌링 시스템의 현재 시각을 주어진 값만큼 이동시킨다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**days**  <br>*optional*|integer (int32)||
|**Query**|**months**  <br>*optional*|integer (int32)||
|**Query**|**timeZone**  <br>*optional*|string||
|**Query**|**timeoutSec**  <br>*optional*|integer (int64)|`5`|
|**Query**|**weeks**  <br>*optional*|integer (int32)||
|**Query**|**years**  <br>*optional*|integer (int32)||


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[ClockResource](#clockresource)|
|**400**|Invalid timezone supplied|No Content|


##### Produces

* `application/json`


<a name="waitforqueuestocomplete"></a>
#### Wait for all available bus events and notifications to be processed
```
GET /rest/v1/test/queues
```


##### Description
빌링 시스템의 모든 큐 작업과 이메일 발송 작업이 끝날때까지 대기한다.


##### Parameters

|Type|Name|Schema|Default|
|---|---|---|---|
|**Query**|**timeoutSec**  <br>*optional*|integer (int64)|`5`|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**412**|Timeout too short|No Content|


<a name="usages_resource"></a>
### Usages

<a name="recordusage"></a>
#### Record usage for a subscription
```
POST /rest/v1/usages
```


##### Description
구독에 usage 사용량을 추가한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Header**|**X-Killbill-Comment**  <br>*optional*|string|
|**Header**|**X-Killbill-CreatedBy**  <br>*optional*|string|
|**Header**|**X-Killbill-Reason**  <br>*optional*|string|
|**Body**|**body**  <br>*optional*|[SubscriptionUsageRecordJson](#subscriptionusagerecordjson)|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**400**|Invalid subscription (e.g. inactive)|No Content|


##### Consumes

* `application/json`


##### Produces

* `application/json`


<a name="getallusage"></a>
#### Retrieve usage for a subscription
```
GET /rest/v1/usages/{subscriptionId}
```


##### Description
주어진 기간동안의 구독의 모든 usage 사용량을 조회한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**subscriptionId**  <br>*required*|string|
|**Query**|**endDate**  <br>*optional*|string|
|**Query**|**startDate**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[RolledUpUsageJson](#rolledupusagejson)|
|**400**|Missing start date or end date|No Content|


##### Produces

* `application/json`


<a name="getusage"></a>
#### Retrieve usage for a subscription and unit type
```
GET /rest/v1/usages/{subscriptionId}/{unitType}
```


##### Description
주어진 unit 과 주어진 기간동안의 구독의 usage 사용량을 조회한다.


##### Parameters

|Type|Name|Schema|
|---|---|---|
|**Path**|**subscriptionId**  <br>*required*|string|
|**Path**|**unitType**  <br>*required*|string|
|**Query**|**endDate**  <br>*optional*|string|
|**Query**|**startDate**  <br>*optional*|string|


##### Responses

|HTTP Code|Description|Schema|
|---|---|---|
|**200**|successful operation|[RolledUpUsageJson](#rolledupusagejson)|
|**400**|Missing start date or end date|No Content|


##### Produces

* `application/json`




<a name="definitions"></a>
## Definitions

<a name="accountbcdjson"></a>
### AccountBCDJson

|Name|Schema|
|---|---|
|**billCycleDayLocal**  <br>*optional*|integer (int32)|


<a name="accountemailjson"></a>
### AccountEmailJson

|Name|Schema|
|---|---|
|**accountId**  <br>*optional*|string (uuid)|
|**auditLogs**  <br>*optional*|< [AuditLogJson](#auditlogjson) > array|
|**email**  <br>*required*|string|


<a name="accountjson"></a>
### AccountJson

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


<a name="accountsalesbalancejson"></a>
### AccountSalesBalanceJson

|Name|Schema|
|---|---|
|**balance**  <br>*optional*|[AmountCurrencyMap](#amountcurrencymap)|
|**credit**  <br>*optional*|[AmountCurrencyMap](#amountcurrencymap)|
|**refund**  <br>*optional*|[AmountCurrencyMap](#amountcurrencymap)|
|**sales**  <br>*optional*|[AmountCurrencyMap](#amountcurrencymap)|
|**withdraw**  <br>*optional*|[AmountCurrencyMap](#amountcurrencymap)|


<a name="accounttimelinejson"></a>
### AccountTimelineJson

|Name|Schema|
|---|---|
|**account**  <br>*optional*|[AccountJson](#accountjson)|
|**bundles**  <br>*optional*|< [BundleJson](#bundlejson) > array|
|**invoices**  <br>*optional*|< [InvoiceJson](#invoicejson) > array|
|**payments**  <br>*optional*|< [InvoicePaymentJson](#invoicepaymentjson) > array|


<a name="amountcurrencymap"></a>
### AmountCurrencyMap
*Type* : < string, number > map


<a name="auditlogjson"></a>
### AuditLogJson

|Name|Schema|
|---|---|
|**changeDate**  <br>*optional*|string (date-time)|
|**changeType**  <br>*optional*|string|
|**changedBy**  <br>*optional*|string|
|**comments**  <br>*optional*|string|
|**reasonCode**  <br>*optional*|string|
|**userToken**  <br>*optional*|string|


<a name="billingrulejson"></a>
### BillingRuleJson

|Name|Schema|
|---|---|
|**billingAlignment**  <br>*optional*|< [billingAlignmentJson](#billingalignmentjson) > array|
|**cancelPolicy**  <br>*optional*|< [cancelPolicyJson](#cancelpolicyjson) > array|
|**changeAlignment**  <br>*optional*|< [changeAlignmentJson](#changealignmentjson) > array|
|**changePolicy**  <br>*optional*|< [changePolicyJson](#changepolicyjson) > array|
|**createAlignment**  <br>*optional*|< [createAlignmentJson](#createalignmentjson) > array|
|**recurringBillingMode**  <br>*optional*|enum (IN_ADVANCE, IN_ARREAR)|


<a name="blockingstatejson"></a>
### BlockingStateJson

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
### BulkBaseSubscriptionAndAddOnsJson

|Name|Schema|
|---|---|
|**baseEntitlementAndAddOns**  <br>*required*|< [SubscriptionJson](#subscriptionjson) > array|


<a name="bundlejson"></a>
### BundleJson

|Name|Schema|
|---|---|
|**accountId**  <br>*required*|string (uuid)|
|**auditLogs**  <br>*optional*|< [AuditLogJson](#auditlogjson) > array|
|**bundleId**  <br>*optional*|string (uuid)|
|**externalKey**  <br>*optional*|string|
|**subscriptions**  <br>*optional*|< [SubscriptionJson](#subscriptionjson) > array|
|**timeline**  <br>*optional*|[BundleTimelineJson](#bundletimelinejson)|


<a name="bundletimelinejson"></a>
### BundleTimelineJson

|Name|Schema|
|---|---|
|**accountId**  <br>*optional*|string (uuid)|
|**auditLogs**  <br>*optional*|< [AuditLogJson](#auditlogjson) > array|
|**bundleId**  <br>*optional*|string (uuid)|
|**events**  <br>*optional*|< [EventSubscriptionJson](#eventsubscriptionjson) > array|
|**externalKey**  <br>*optional*|string|


<a name="clockresource"></a>
### ClockResource

|Name|Schema|
|---|---|
|**currentUtcTime**  <br>*optional*|string (date-time)|
|**localDate**  <br>*optional*|string (date)|
|**timeZone**  <br>*optional*|string|


<a name="combopaymenttransactionjson"></a>
### ComboPaymentTransactionJson

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
### CreditJson

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
### CustomFieldJson

|Name|Schema|
|---|---|
|**auditLogs**  <br>*optional*|< [AuditLogJson](#auditlogjson) > array|
|**customFieldId**  <br>*optional*|string (uuid)|
|**name**  <br>*required*|string|
|**objectId**  <br>*optional*|string (uuid)|
|**objectType**  <br>*optional*|enum (ACCOUNT, ACCOUNT_EMAIL, BLOCKING_STATES, BUNDLE, CUSTOM_FIELD, INVOICE, PAYMENT, TRANSACTION, INVOICE_ITEM, INVOICE_PAYMENT, SUBSCRIPTION, SUBSCRIPTION_EVENT, SERVICE_BROADCAST, PAYMENT_ATTEMPT, PAYMENT_METHOD, REFUND, TAG, TAG_DEFINITION, TENANT, TENANT_KVS)|
|**value**  <br>*required*|string|


<a name="durationjson"></a>
### DurationJson

|Name|Schema|
|---|---|
|**number**  <br>*optional*|integer (int32)|
|**unit**  <br>*optional*|enum (DAYS, MONTHS, YEARS, UNLIMITED)|


<a name="eventsubscriptionjson"></a>
### EventSubscriptionJson

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
### InvoiceDryRunJson

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
### InvoiceEmailJson

|Name|Description|Schema|
|---|---|---|
|**accountId**  <br>*optional*||string (uuid)|
|**auditLogs**  <br>*optional*||< [AuditLogJson](#auditlogjson) > array|
|**isNotifiedForInvoices**  <br>*optional*|**Default** : `false`|boolean|


<a name="invoiceitemjson"></a>
### InvoiceItemJson

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
### InvoiceJson

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
### InvoicePaymentJson

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
### InvoicePaymentTransactionJson
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
### IterablePluginPropertyJson
*Type* : object


<a name="listinvoiceitemjson"></a>
### ListInvoiceItemJson
*Type* : < [InvoiceItemJson](#invoiceitemjson) > array


<a name="listonetimebuyrequestjson"></a>
### ListOneTimeBuyRequestJson
*Type* : < [OneTimeBuyRequestJson](#onetimebuyrequestjson) > array


<a name="notificationrulejson"></a>
### NotificationRuleJson

|Name|Schema|
|---|---|
|**FAILED_PAYMENT**  <br>*optional*|boolean|
|**INVOICE**  <br>*optional*|boolean|
|**PAYMENT_REFUND**  <br>*optional*|boolean|
|**SUBSCRIPTION_CANCELLATION_EFFECTIVE**  <br>*optional*|boolean|
|**SUBSCRIPTION_CANCELLATION_REQUESTED**  <br>*optional*|boolean|
|**SUCCESSFUL_PAYMENT**  <br>*optional*|boolean|


<a name="onetimebuyjson"></a>
### OneTimeBuyJson

|Name|Schema|
|---|---|
|**account_id**  <br>*optional*|string|
|**amount**  <br>*optional*|number|
|**billing_date**  <br>*optional*|string|
|**bundle_id**  <br>*optional*|string|
|**created_date**  <br>*optional*|string|
|**currency**  <br>*optional*|string|
|**effective_date**  <br>*optional*|string|
|**invoice_id**  <br>*optional*|string|
|**invoice_item_id**  <br>*optional*|string|
|**organization_id**  <br>*optional*|string|
|**plan_display_name**  <br>*optional*|string|
|**plan_name**  <br>*optional*|string|
|**product_id**  <br>*optional*|string|
|**record_id**  <br>*optional*|integer (int32)|
|**state**  <br>*optional*|string|
|**tenant_id**  <br>*optional*|string|
|**version**  <br>*optional*|number|


<a name="onetimebuyrequestjson"></a>
### OneTimeBuyRequestJson

|Name|Schema|
|---|---|
|**bundleId**  <br>*optional*|string|
|**planName**  <br>*optional*|string|
|**productCategory**  <br>*optional*|string|


<a name="organizationemailjson"></a>
### OrganizationEmailJson

|Name|Schema|
|---|---|
|**email**  <br>*optional*|string|
|**id**  <br>*optional*|string|
|**is_active**  <br>*optional*|string|
|**is_default**  <br>*optional*|string|
|**organization_id**  <br>*optional*|string|
|**reg_dt**  <br>*optional*|string|


<a name="organizationjson"></a>
### OrganizationJson

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


<a name="organizationsalesperdatesummaryjson"></a>
### OrganizationSalesPerDateSummaryJson

|Name|Schema|
|---|---|
|**currencies**  <br>*optional*|< string > array|
|**end_date**  <br>*optional*|string|
|**net_summary**  <br>*optional*|[SalesPerDateSummaryJson](#salesperdatesummaryjson)|
|**start_date**  <br>*optional*|string|
|**total_revenue**  <br>*optional*|[SalesPerDateSummaryJson](#salesperdatesummaryjson)|


<a name="overdueconditionjson"></a>
### OverdueConditionJson

|Name|Schema|
|---|---|
|**controlTagExclusion**  <br>*optional*|enum (AUTO_PAY_OFF, AUTO_INVOICING_OFF, OVERDUE_ENFORCEMENT_OFF, WRITTEN_OFF, MANUAL_PAY, TEST, PARTNER)|
|**controlTagInclusion**  <br>*optional*|enum (AUTO_PAY_OFF, AUTO_INVOICING_OFF, OVERDUE_ENFORCEMENT_OFF, WRITTEN_OFF, MANUAL_PAY, TEST, PARTNER)|
|**numberOfUnpaidInvoicesEqualsOrExceeds**  <br>*optional*|integer (int32)|
|**responseForLastFailedPayment**  <br>*optional*|< enum (INVALID_CARD, EXPIRED_CARD, LOST_OR_STOLEN_CARD, DO_NOT_HONOR, INSUFFICIENT_FUNDS, DECLINE, PROCESSING_ERROR, INVALID_AMOUNT, DUPLICATE_TRANSACTION, OTHER) > array|
|**timeSinceEarliestUnpaidInvoiceEqualsOrExceeds**  <br>*optional*|[DurationJson](#durationjson)|
|**totalUnpaidInvoiceBalanceEqualsOrExceeds**  <br>*optional*|number|


<a name="overduejson"></a>
### OverdueJson

|Name|Schema|
|---|---|
|**initialReevaluationInterval**  <br>*optional*|integer (int32)|
|**overdueStates**  <br>*optional*|< [OverdueStateConfigJson](#overduestateconfigjson) > array|


<a name="overduestateconfigjson"></a>
### OverdueStateConfigJson

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
### OverdueStateJson

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
### PaymentAttemptJson
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
### PaymentJson

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
### PaymentMethodJson

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
### PaymentMethodPluginDetailJson

|Name|Description|Schema|
|---|---|---|
|**externalPaymentMethodId**  <br>*optional*||string|
|**isDefaultPaymentMethod**  <br>*optional*|**Default** : `false`|boolean|
|**properties**  <br>*optional*||< [PluginPropertyJson](#pluginpropertyjson) > array|


<a name="paymenttransactionjson"></a>
### PaymentTransactionJson
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


<a name="perdatejson"></a>
### PerDateJson
*Type* : < string, < object > array > map


<a name="phasejson"></a>
### PhaseJson

|Name|Schema|
|---|---|
|**duration**  <br>*optional*|[DurationJson](#durationjson)|
|**fixed**  <br>*optional*|[fixedJson](#fixedjson)|
|**recurring**  <br>*optional*|[recurringJson](#recurringjson)|
|**type**  <br>*optional*|enum (TRIAL, DISCOUNT, FIXEDTERM, EVERGREEN)|
|**usages**  <br>*optional*|< [UsageJson](#usagejson) > array|


<a name="phasepriceoverridejson"></a>
### PhasePriceOverrideJson

|Name|Schema|
|---|---|
|**fixedPrice**  <br>*optional*|number|
|**phaseName**  <br>*optional*|string|
|**phaseType**  <br>*optional*|string|
|**recurringPrice**  <br>*optional*|number|


<a name="planjson"></a>
### PlanJson

|Name|Schema|
|---|---|
|**display_name**  <br>*optional*|string|
|**finalPhase**  <br>*optional*|[PhaseJson](#phasejson)|
|**initialPhases**  <br>*optional*|< [PhaseJson](#phasejson) > array|
|**is_active**  <br>*optional*|enum (Y, N)|
|**name**  <br>*optional*|string|
|**number_of_subscriptions**  <br>*optional*|number|
|**number_of_subscriptions_referenced_by_version**  <br>*optional*|number|
|**overwriteVendors**  <br>*optional*|< [VendorJson](#vendorjson) > array|


<a name="pluginpropertyjson"></a>
### PluginPropertyJson

|Name|Description|Schema|
|---|---|---|
|**isUpdatable**  <br>*optional*|**Default** : `false`|boolean|
|**key**  <br>*optional*||string|
|**value**  <br>*optional*||string|


<a name="pricejson"></a>
### PriceJson

|Name|Schema|
|---|---|
|**currency**  <br>*optional*|string|
|**value**  <br>*optional*|number|


<a name="productdistributionhistory"></a>
### ProductDistributionHistory

|Name|Schema|
|---|---|
|**amount**  <br>*optional*|number|
|**buyer_id**  <br>*optional*|string|
|**created_date**  <br>*optional*|string|
|**currency**  <br>*optional*|string|
|**format_date**  <br>*optional*|string|
|**invoice_id**  <br>*optional*|string|
|**invoice_item_id**  <br>*optional*|string|
|**invoice_item_type**  <br>*optional*|string|
|**linked_invoice_item_id**  <br>*optional*|string|
|**notes**  <br>*optional*|string|
|**organization_id**  <br>*optional*|string|
|**original_amount**  <br>*optional*|number|
|**plan_name**  <br>*optional*|string|
|**price_type**  <br>*optional*|enum (ONE_TIME, USAGE, RECURRING, FIXED)|
|**product_id**  <br>*optional*|string|
|**ratio**  <br>*optional*|number|
|**record_id**  <br>*optional*|integer (int32)|
|**subscription_id**  <br>*optional*|string|
|**tenant_id**  <br>*optional*|string|
|**transaction_type**  <br>*optional*|enum (CREATION, ADJUSTMENT, WITHDRAW, CREDIT)|
|**usage_name**  <br>*optional*|string|
|**vendor_id**  <br>*optional*|string|
|**version**  <br>*optional*|number|


<a name="productjson"></a>
### ProductJson

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
|**vendors**  <br>*optional*|< [VendorJson](#vendorjson) > array|


<a name="productversionjson"></a>
### ProductVersionJson

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
### RetryRuleJson

|Name|Schema|
|---|---|
|**retry**  <br>*optional*|string|


<a name="rolledupunitjson"></a>
### RolledUpUnitJson

|Name|Schema|
|---|---|
|**amount**  <br>*optional*|integer (int64)|
|**unitType**  <br>*optional*|string|


<a name="rolledupusagejson"></a>
### RolledUpUsageJson

|Name|Schema|
|---|---|
|**endDate**  <br>*optional*|string (date)|
|**rolledUpUnits**  <br>*optional*|< [RolledUpUnitJson](#rolledupunitjson) > array|
|**startDate**  <br>*optional*|string (date)|
|**subscriptionId**  <br>*optional*|string (uuid)|


<a name="salesperdatesummaryjson"></a>
### SalesPerDateSummaryJson

|Name|Schema|
|---|---|
|**balance**  <br>*optional*|[SummaryAndPerDateJson](#summaryandperdatejson)|
|**credit**  <br>*optional*|[SummaryAndPerDateJson](#summaryandperdatejson)|
|**currencies**  <br>*optional*|< string > array|
|**end_date**  <br>*optional*|string|
|**refund**  <br>*optional*|[SummaryAndPerDateJson](#summaryandperdatejson)|
|**sales**  <br>*optional*|[SummaryAndPerDateJson](#summaryandperdatejson)|
|**start_date**  <br>*optional*|string|
|**withdraw**  <br>*optional*|[SummaryAndPerDateJson](#summaryandperdatejson)|


<a name="saleswithdrawrequest"></a>
### SalesWithdrawRequest

|Name|Schema|
|---|---|
|**amount**  <br>*optional*|number|
|**currency**  <br>*optional*|string|
|**notes**  <br>*optional*|string|
|**transactionType**  <br>*optional*|enum (WITHDRAW, CREDIT)|


<a name="subscriptionjson"></a>
### SubscriptionJson

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
### SubscriptionUsageRecordJson

|Name|Schema|
|---|---|
|**subscriptionId**  <br>*required*|string (uuid)|
|**trackingId**  <br>*optional*|string|
|**unitUsageRecords**  <br>*required*|< [UnitUsageRecordJson](#unitusagerecordjson) > array|


<a name="summaryandperdatejson"></a>
### SummaryAndPerDateJson

|Name|Schema|
|---|---|
|**per_date**  <br>*optional*|[PerDateJson](#perdatejson)|
|**summary**  <br>*optional*|[SummaryJson](#summaryjson)|


<a name="summaryjson"></a>
### SummaryJson

|Name|Schema|
|---|---|
|**per_plan_name**  <br>*optional*|< string, [AmountCurrencyMap](#amountcurrencymap) > map|
|**per_price_type**  <br>*optional*|< string, [AmountCurrencyMap](#amountcurrencymap) > map|
|**per_product_id**  <br>*optional*|< string, [AmountCurrencyMap](#amountcurrencymap) > map|
|**per_usage_name**  <br>*optional*|< string, [AmountCurrencyMap](#amountcurrencymap) > map|
|**per_vendor_id**  <br>*optional*|< string, [AmountCurrencyMap](#amountcurrencymap) > map|
|**total**  <br>*optional*|[AmountCurrencyMap](#amountcurrencymap)|


<a name="tagdefinitionjson"></a>
### TagDefinitionJson

|Name|Description|Schema|
|---|---|---|
|**applicableObjectTypes**  <br>*optional*||< string > array|
|**auditLogs**  <br>*optional*||< [AuditLogJson](#auditlogjson) > array|
|**description**  <br>*required*||string|
|**id**  <br>*optional*||string (uuid)|
|**isControlTag**  <br>*optional*|**Default** : `false`|boolean|
|**name**  <br>*required*||string|


<a name="tagjson"></a>
### TagJson

|Name|Schema|
|---|---|
|**auditLogs**  <br>*optional*|< [AuditLogJson](#auditlogjson) > array|
|**objectId**  <br>*optional*|string (uuid)|
|**objectType**  <br>*optional*|enum (ACCOUNT, ACCOUNT_EMAIL, BLOCKING_STATES, BUNDLE, CUSTOM_FIELD, INVOICE, PAYMENT, TRANSACTION, INVOICE_ITEM, INVOICE_PAYMENT, SUBSCRIPTION, SUBSCRIPTION_EVENT, SERVICE_BROADCAST, PAYMENT_ATTEMPT, PAYMENT_METHOD, REFUND, TAG, TAG_DEFINITION, TENANT, TENANT_KVS)|
|**tagDefinitionId**  <br>*optional*|string (uuid)|
|**tagDefinitionName**  <br>*optional*|string|
|**tagId**  <br>*optional*|string (uuid)|


<a name="templatejson"></a>
### TemplateJson

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
### TemplatePerNotificationJson

|Name|Schema|
|---|---|
|**FAILED_PAYMENT**  <br>*optional*|< [TemplateJson](#templatejson) > array|
|**INVOICE**  <br>*optional*|< [TemplateJson](#templatejson) > array|
|**PAYMENT_REFUND**  <br>*optional*|< [TemplateJson](#templatejson) > array|
|**SUBSCRIPTION_CANCELLATION_EFFECTIVE**  <br>*optional*|< [TemplateJson](#templatejson) > array|
|**SUBSCRIPTION_CANCELLATION_REQUESTED**  <br>*optional*|< [TemplateJson](#templatejson) > array|
|**SUCCESSFUL_PAYMENT**  <br>*optional*|< [TemplateJson](#templatejson) > array|


<a name="tenantjson"></a>
### TenantJson

|Name|Schema|
|---|---|
|**apiKey**  <br>*required*|string|
|**apiSecret**  <br>*required*|string|
|**auditLogs**  <br>*optional*|< [AuditLogJson](#auditlogjson) > array|
|**externalKey**  <br>*optional*|string|
|**tenantId**  <br>*optional*|string (uuid)|


<a name="tenantkeyjson"></a>
### TenantKeyJson

|Name|Schema|
|---|---|
|**key**  <br>*optional*|string|
|**values**  <br>*optional*|< string > array|


<a name="tierjson"></a>
### TierJson

|Name|Schema|
|---|---|
|**max**  <br>*optional*|number|
|**prices**  <br>*optional*|< [PriceJson](#pricejson) > array|
|**size**  <br>*optional*|number|
|**unit**  <br>*optional*|string|


<a name="tokenjson"></a>
### TokenJson

|Name|Description|Schema|
|---|---|---|
|**access_token**  <br>*optional*||string|
|**expires_in**  <br>*optional*||number|
|**refresh_token**  <br>*optional*||string|
|**status**  <br>*optional*||number|
|**token_type**  <br>*optional*|**Default** : `"JWT"`|string|


<a name="unitusagerecordjson"></a>
### UnitUsageRecordJson

|Name|Schema|
|---|---|
|**unitType**  <br>*optional*|string|
|**usageRecords**  <br>*optional*|< [UsageRecordJson](#usagerecordjson) > array|


<a name="usagejson"></a>
### UsageJson

|Name|Schema|
|---|---|
|**billingMode**  <br>*optional*|enum (IN_ADVANCE, IN_ARREAR)|
|**billingPeriod**  <br>*optional*|enum (DAILY, WEEKLY, BIWEEKLY, THIRTY_DAYS, MONTHLY, QUARTERLY, BIANNUAL, ANNUAL, BIENNIAL, NO_BILLING_PERIOD)|
|**display_name**  <br>*optional*|string|
|**name**  <br>*optional*|string|
|**overwriteVendors**  <br>*optional*|< [VendorJson](#vendorjson) > array|
|**tiers**  <br>*optional*|< [TierJson](#tierjson) > array|
|**usageType**  <br>*optional*|enum (CAPACITY, CONSUMABLE)|


<a name="usagerecordjson"></a>
### UsageRecordJson

|Name|Schema|
|---|---|
|**amount**  <br>*optional*|integer (int64)|
|**recordDate**  <br>*optional*|string (date)|


<a name="userjson"></a>
### UserJson

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


<a name="vendorjson"></a>
### VendorJson

|Name|Schema|
|---|---|
|**account_id**  <br>*optional*|string|
|**ratio**  <br>*optional*|number|


<a name="billingalignmentjson"></a>
### billingAlignmentJson

|Name|Schema|
|---|---|
|**billingAlignment**  <br>*optional*|enum (ACCOUNT, BUNDLE, SUBSCRIPTION)|
|**billingPeriod**  <br>*optional*|enum (DAILY, WEEKLY, BIWEEKLY, THIRTY_DAYS, MONTHLY, QUARTERLY, BIANNUAL, ANNUAL, BIENNIAL, NO_BILLING_PERIOD)|
|**phaseType**  <br>*optional*|enum (TRIAL, DISCOUNT, FIXEDTERM, EVERGREEN)|
|**productCategory**  <br>*optional*|enum (BASE, ADD_ON)|


<a name="cancelpolicyjson"></a>
### cancelPolicyJson

|Name|Schema|
|---|---|
|**billingActionPolicy**  <br>*optional*|enum (START_OF_TERM, END_OF_TERM, IMMEDIATE, ILLEGAL)|
|**billingPeriod**  <br>*optional*|enum (DAILY, WEEKLY, BIWEEKLY, THIRTY_DAYS, MONTHLY, QUARTERLY, BIANNUAL, ANNUAL, BIENNIAL, NO_BILLING_PERIOD)|
|**phaseType**  <br>*optional*|enum (TRIAL, DISCOUNT, FIXEDTERM, EVERGREEN)|
|**productCategory**  <br>*optional*|enum (BASE, ADD_ON)|


<a name="changealignmentjson"></a>
### changeAlignmentJson

|Name|Schema|
|---|---|
|**fromBillingPeriod**  <br>*optional*|enum (DAILY, WEEKLY, BIWEEKLY, THIRTY_DAYS, MONTHLY, QUARTERLY, BIANNUAL, ANNUAL, BIENNIAL, NO_BILLING_PERIOD)|
|**fromProductCategory**  <br>*optional*|enum (BASE, ADD_ON)|
|**phaseType**  <br>*optional*|enum (TRIAL, DISCOUNT, FIXEDTERM, EVERGREEN)|
|**planAlignmentChange**  <br>*optional*|enum (START_OF_BUNDLE, START_OF_SUBSCRIPTION, CHANGE_OF_PLAN)|
|**toBillingPeriod**  <br>*optional*|enum (DAILY, WEEKLY, BIWEEKLY, THIRTY_DAYS, MONTHLY, QUARTERLY, BIANNUAL, ANNUAL, BIENNIAL, NO_BILLING_PERIOD)|
|**toProductCategory**  <br>*optional*|enum (BASE, ADD_ON)|


<a name="changepolicyjson"></a>
### changePolicyJson

|Name|Schema|
|---|---|
|**billingActionPolicy**  <br>*optional*|enum (START_OF_TERM, END_OF_TERM, IMMEDIATE, ILLEGAL)|
|**fromBillingPeriod**  <br>*optional*|enum (DAILY, WEEKLY, BIWEEKLY, THIRTY_DAYS, MONTHLY, QUARTERLY, BIANNUAL, ANNUAL, BIENNIAL, NO_BILLING_PERIOD)|
|**fromProductCategory**  <br>*optional*|enum (BASE, ADD_ON)|
|**phaseType**  <br>*optional*|enum (TRIAL, DISCOUNT, FIXEDTERM, EVERGREEN)|
|**toBillingPeriod**  <br>*optional*|enum (DAILY, WEEKLY, BIWEEKLY, THIRTY_DAYS, MONTHLY, QUARTERLY, BIANNUAL, ANNUAL, BIENNIAL, NO_BILLING_PERIOD)|
|**toProductCategory**  <br>*optional*|enum (BASE, ADD_ON)|


<a name="createalignmentjson"></a>
### createAlignmentJson

|Name|Schema|
|---|---|
|**planAlignmentCreate**  <br>*optional*|enum (START_OF_BUNDLE, START_OF_SUBSCRIPTION)|


<a name="fixedjson"></a>
### fixedJson

|Name|Schema|
|---|---|
|**fixedPrice**  <br>*optional*|< [PriceJson](#pricejson) > array|


<a name="recurringjson"></a>
### recurringJson

|Name|Schema|
|---|---|
|**billingPeriod**  <br>*optional*|enum (DAILY, WEEKLY, BIWEEKLY, THIRTY_DAYS, MONTHLY, QUARTERLY, BIANNUAL, ANNUAL, BIENNIAL, NO_BILLING_PERIOD)|
|**recurringPrice**  <br>*optional*|< [PriceJson](#pricejson) > array|






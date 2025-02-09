/**
 * Created by Seungpil Park on 2016. 9. 6..
 */
var uBilling = function (host, port) {
    this.host = host;
    this.port = port;
    this.schema = 'http';
    if (!host && !port) {
        this.baseUrl = '';
    } else {
        this.baseUrl = this.schema + '://' + this.host + ':' + this.port;
    }
    this.user = undefined;
    this.organization = undefined;

    $(document).ajaxSend(function (e, xhr, options) {
        var token = localStorage.getItem('uengine-billing-access_token');
        var organizationId = localStorage.getItem('uengine-billing-organization_id');
        xhr.setRequestHeader('Authorization', token);
        xhr.setRequestHeader('X-organization-id', organizationId);
    });
};
uBilling.prototype = {
    logout: function () {
        localStorage.removeItem('uengine-billing-access_token');
        localStorage.removeItem('uengine-billing-organization_id');
    },
    setDefaultOrganization: function (id) {
        localStorage.setItem('uengine-billing-organization_id', id);
    },
    getDefaultOrganization: function () {
        return localStorage.getItem('uengine-billing-organization_id');
    },

    login: function (data) {
        var me = this;
        var username = data.username;
        var password = data.password;
        var scope = data.scope;
        var deferred = $.Deferred();
        var promise = $.ajax({
            type: "POST",
            url: me.baseUrl + '/rest/v1/access_token',
            data: 'username=' + username + '&password=' + password + '&scope=' + scope,
            contentType: "application/x-www-form-urlencoded",
            dataType: "json"
        });
        promise.done(function (response) {
            if (response['access_token']) {
                console.log('login success');
                var token = response['access_token'];
                localStorage.setItem("uengine-billing-access_token", token);
                me.user = response;
                deferred.resolve(response);
            } else {
                console.log('login failed');
                localStorage.removeItem("access_token");
                deferred.reject();
            }
        });
        promise.fail(function (response, status, errorThrown) {
            console.log('login failed', errorThrown, response.responseText);
            localStorage.removeItem("access_token");
            deferred.reject(response);
        });
        return deferred.promise();
    },
    validateToken: function () {
        console.log('Validating token...');
        var me = this;
        var token = localStorage.getItem("uengine-billing-access_token");
        var deferred = $.Deferred();
        var promise = $.ajax({
            type: "GET",
            url: me.baseUrl + '/rest/v1/token_info?authorization=' + token,
            dataType: "json",
            async: false
        });
        promise.done(function (response) {
            //alert('validateToken success');
            console.log('validateToken success');
            deferred.resolve(response);
        });
        promise.fail(function (response, status, errorThrown) {
            //alert('validateToken failed');
            console.log('validateToken failed', errorThrown, response.responseText);
            deferred.reject(response);
        });
        return deferred.promise();
    },
    getClock: function () {
        var options = {
            type: "GET",
            url: '/rest/v1/test/clock',
            dataType: 'json'
        };
        return this.send(options);
    },
    updateClock: function (requestedDate) {
        var options = {
            type: "POST",
            url: '/rest/v1/test/clock?requestedDate=' + requestedDate + '&timeoutSec=5',
            contentType: "text/plain",
            dataType: 'json'
        };
        return this.send(options);
    },
    getOrganizations: function () {
        console.log('getOrganizations...');
        var me = this;
        var deferred = $.Deferred();
        var promise = $.ajax({
            type: "GET",
            url: me.baseUrl + '/rest/v1/organization',
            dataType: "json",
            async: false
        });
        promise.done(function (response) {
            console.log('getOrganizations success');
            deferred.resolve(response);
        });
        promise.fail(function (response, status, errorThrown) {
            console.log('getOrganizations failed', errorThrown, response.responseText);
            deferred.reject(response);
        });
        return deferred.promise();
    },
    createOrganization: function (data) {
        var me = this;
        var deferred = $.Deferred();
        var promise = $.ajax({
            type: "POST",
            url: me.baseUrl + '/rest/v1/organization',
            data: JSON.stringify(data),
            contentType: "application/json"
        });
        promise.done(function (response, status, xhr) {
            console.log('createOrganization success');
            var locationHeader = xhr.getResponseHeader('Location');
            var id = locationHeader.substring(locationHeader.lastIndexOf('/') + 1);
            deferred.resolve(id);
        });
        promise.fail(function (response, status, errorThrown) {
            console.log('createOrganization failed', errorThrown, response.responseText);
            deferred.reject(response);
        });
        return deferred.promise();
    },
    updateOrganization: function (data) {
        var me = this;
        var deferred = $.Deferred();
        var promise = $.ajax({
            type: "PUT",
            url: me.baseUrl + '/rest/v1/organization/' + me.getDefaultOrganization(),
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: "json"
        });
        promise.done(function (response, status, xhr) {
            console.log('updateOrganization success');
            deferred.resolve(response);
        });
        promise.fail(function (response, status, errorThrown) {
            console.log('updateOrganization failed', errorThrown, response.responseText);
            deferred.reject(response);
        });
        return deferred.promise();
    },
    getOrganizationEmails: function () {
        var options = {
            type: "GET",
            url: '/rest/v1/organizationEmail',
            dataType: "json"
        };
        return this.send(options);
    },
    createOrganizationEmail: function (data) {
        var options = {
            type: "POST",
            url: '/rest/v1/organizationEmail',
            data: JSON.stringify(data),
            contentType: "application/json"
        };
        return this.send(options);
    },
    updateOrganizationEmail: function (id, data) {
        var options = {
            type: "PUT",
            url: '/rest/v1/organizationEmail/' + id,
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: "json"
        };
        return this.send(options);
    },
    deleteOrganizationEmail: function (id) {
        var options = {
            type: "DELETE",
            url: '/rest/v1/organizationEmail/' + id
        };
        return this.send(options);
    },
    createAccount: function (data) {
        var options = {
            type: "POST",
            url: '/rest/v1/accounts',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text',
            resolve: function (response, status, xhr) {
                var locationHeader = xhr.getResponseHeader('Location');
                return locationHeader.substring(locationHeader.lastIndexOf('/') + 1);
            }
        };
        return this.send(options);
    },
    updateAccount: function (accountId, data) {
        var options = {
            type: "PUT",
            url: '/rest/v1/accounts/' + accountId,
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'json'
        };
        return this.send(options);
    },
    updateAccountBcd: function (accountId, bcd) {
        var options = {
            type: "PUT",
            url: '/rest/v1/accounts/' + accountId + '/bcd',
            data: JSON.stringify({
                billCycleDayLocal: bcd
            }),
            contentType: "application/json",
            dataType: 'json'
        };
        return this.send(options);
    },
    getAccount: function (accountId) {
        var options = {
            type: "GET",
            url: '/rest/v1/accounts/' + accountId + '?accountWithBalance=true&accountWithBalanceAndCBA=true&audit=NONE',
            dataType: 'json'
        };
        return this.send(options);
    },
    getAccountIds: function (ids) {
        var options = {
            type: "POST",
            url: '/rest/v1/accountsByIds',
            data: JSON.stringify(ids),
            contentType: "application/json",
            dataType: 'json'
        };
        return this.send(options);
    },
    getAccountSearch: function (searchKey, offset, limit) {
        var data = {
            offset: offset ? offset : 0,
            limit: limit ? limit : 100,
            accountWithBalance: true,
            accountWithBalanceAndCBA: true,
            audit: 'NONE'
        };
        var url = searchKey ? '/rest/v1/accounts/search/' + searchKey : '/rest/v1/accounts/pagination';
        var options = {
            type: "GET",
            url: url,
            dataType: 'json',
            data: data,
            resolve: function (response, status, xhr) {
                var total = parseInt(xhr.getResponseHeader('x-uengine-pagination-totalnbrecords'));
                var filtered = parseInt(xhr.getResponseHeader('x-uengine-pagination-maxnbrecords'));
                return {
                    data: response,
                    total: total,
                    filtered: filtered,
                    offset: data.offset,
                    limit: data.limit
                };
            }
        };
        return this.send(options);
    },
    deleteAccount: function (accountId) {
        var options = {
            type: "DELETE",
            url: '/rest/v1/accounts/' + accountId,
            dataType: 'text'
        };
        return this.send(options);
    },
    createAccountCustomFields: function (accountId, data) {
        var options = {
            type: "POST",
            url: '/rest/v1/accounts/' + accountId + '/customFields',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text'
        };
        return this.send(options);
    },
    getAccountCustomFields: function (accountId) {
        var options = {
            type: "GET",
            url: '/rest/v1/accounts/' + accountId + '/customFields',
            dataType: 'json'
        };
        return this.send(options);
    },
    deleteAccountCustomFields: function (accountId, data) {
        console.log(accountId, data);
        var options = {
            type: "DELETE",
            url: '/rest/v1/accounts/' + accountId + '/customFields',
            data: data,
            dataType: 'text'
        };
        return this.send(options);
    },
    getBillingRule: function () {
        var options = {
            type: "GET",
            url: '/rest/v1/rule',
            dataType: 'json'
        };
        return this.send(options);
    },
    uploadBillingRule: function (data) {
        var options = {
            type: "POST",
            url: '/rest/v1/rule',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text'
        };
        return this.send(options);
    },
    getOverdueRule: function () {
        var options = {
            type: "GET",
            url: '/rest/v1/overdue',
            dataType: 'json'
        };
        return this.send(options);
    },
    uploadOverdueRule: function (data) {
        var options = {
            type: "POST",
            url: '/rest/v1/overdue',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text'
        };
        return this.send(options);
    },
    getRetry: function () {
        var options = {
            type: "GET",
            url: '/rest/v1/retry',
            dataType: 'json'
        };
        return this.send(options);
    },
    uploadRetry: function (data) {
        var options = {
            type: "POST",
            url: '/rest/v1/retry',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text'
        };
        return this.send(options);
    },
    createProduct: function (data) {
        var options = {
            type: "POST",
            url: '/rest/v1/product',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text',
            resolve: function (response, status, xhr) {
                var locationHeader = xhr.getResponseHeader('Location');
                return locationHeader.substring(locationHeader.lastIndexOf('/') + 1);
            }
        };
        return this.send(options);
    },
    updateProduct: function (product_id, data) {
        var options = {
            type: "PUT",
            url: '/rest/v1/product/' + product_id,
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'json'
        };
        return this.send(options);
    },
    updateProductActive: function (product_id, data) {
        var options = {
            type: "PUT",
            url: '/rest/v1/product/' + product_id + '/active',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'json'
        };
        return this.send(options);
    },
    getProduct: function (product_id) {
        var options = {
            type: "GET",
            url: '/rest/v1/product/' + product_id,
            dataType: 'json'
        };
        return this.send(options);
    },
    getProductSearch: function (searchKey, offset, limit, category) {
        var data = {
            offset: offset ? offset : 0,
            limit: limit ? limit : 100
        };
        if (category) {
            data['category'] = category;
        }
        var url = searchKey ? '/rest/v1/product/search/' + searchKey : '/rest/v1/product/pagination';
        var options = {
            type: "GET",
            url: url,
            dataType: 'json',
            data: data,
            resolve: function (response, status, xhr) {
                var total = parseInt(xhr.getResponseHeader('x-uengine-pagination-totalnbrecords'));
                var filtered = parseInt(xhr.getResponseHeader('x-uengine-pagination-maxnbrecords'));
                return {
                    data: response,
                    total: total,
                    filtered: filtered,
                    offset: data.offset,
                    limit: data.limit
                };
            }
        };
        return this.send(options);
    },
    deleteProduct: function (product_id) {
        var options = {
            type: "DELETE",
            url: '/rest/v1/product/' + product_id,
            dataType: 'text'
        };
        return this.send(options);
    },
    getProductVersions: function (product_id) {
        var options = {
            type: "GET",
            url: '/rest/v1/product/' + product_id + '/version',
            dataType: 'json'
        };
        return this.send(options);
    },
    getProductVersion: function (product_id, version) {
        var options = {
            type: "GET",
            url: '/rest/v1/product/' + product_id + '/version/' + version,
            dataType: 'json'
        };
        return this.send(options);
    },
    updateProductVersion: function (product_id, version, data) {
        var options = {
            type: "PUT",
            url: '/rest/v1/product/' + product_id + '/version/' + version,
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'json'
        };
        return this.send(options);
    },
    createProductVersion: function (product_id, data) {
        var options = {
            type: "POST",
            url: '/rest/v1/product/' + product_id + '/version',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text',
            resolve: function (response, status, xhr) {
                var locationHeader = xhr.getResponseHeader('Location');
                return locationHeader.substring(locationHeader.lastIndexOf('/') + 1);
            }
        };
        return this.send(options);
    },

    getAccountOverdue: function (accountId) {
        var options = {
            type: "GET",
            url: '/rest/v1/accounts/' + accountId + '/overdue',
            dataType: 'json'
        };
        return this.send(options);
    },

    invoiceDryRun: function (accountId, data) {
        var options = {
            type: "POST",
            url: '/rest/v1/invoices/dryRun?accountId=' + accountId,
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'json'
        };
        return this.send(options);
    },
    updateAccountEmailNotifications: function (accountId, notifications) {
        var data = {
            isNotifiedForInvoices: notifications
        };
        var options = {
            type: "PUT",
            url: '/rest/v1/accounts/' + accountId + '/emailNotifications',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text'
        };
        return this.send(options);
    },
    getTagDefinitions: function () {
        var options = {
            type: "GET",
            url: '/rest/v1/tagDefinitions?audit=NONE',
            dataType: 'json'
        };
        return this.send(options);
    },
    getAccountTags: function (account_id) {
        var options = {
            type: "GET",
            url: '/rest/v1/accounts/' + account_id + '/tags?audit=NONE&includedDeleted=false',
            dataType: 'json'
        };
        return this.send(options);
    },
    createAccountTags: function (accountId, tags) {
        var options = {
            type: "POST",
            url: '/rest/v1/accounts/' + accountId + '/tags?tagList=' + tags.join(),
            //data: null,
            contentType: "application/json",
            dataType: 'text'
        };
        return this.send(options);
    },
    deleteAccountTags: function (accountId, tags) {
        var options = {
            type: "DELETE",
            url: '/rest/v1/accounts/' + accountId + '/tags?tagList=' + tags.join(),
            dataType: 'text'
        };
        return this.send(options);
    },

    getAccountEmails: function (account_id) {
        var options = {
            type: "GET",
            url: '/rest/v1/accounts/' + account_id + '/emails',
            dataType: 'json'
        };
        return this.send(options);
    },
    createAccountEmails: function (accountId, email) {
        var data = {
            "accountId": accountId,
            "email": email
        };
        var options = {
            type: "POST",
            url: '/rest/v1/accounts/' + accountId + '/emails',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text'
        };
        return this.send(options);
    },
    deleteAccountEmails: function (accountId, email) {
        var options = {
            type: "DELETE",
            url: '/rest/v1/accounts/' + accountId + '/emails/' + email,
            dataType: 'text'
        };
        return this.send(options);
    },
    getAccountPaymentMethods: function (account_id) {
        var options = {
            type: "GET",
            url: '/rest/v1/accounts/' + account_id + '/paymentMethods?withPluginInfo=true&audit=NONE',
            dataType: 'json'
        };
        return this.send(options);
    },
    createAccountPaymentMethod: function (account_id, data, isDefault) {
        var options = {
            type: "POST",
            url: '/rest/v1/accounts/' + account_id + '/paymentMethods?isDefault=' + isDefault + '&payAllUnpaidInvoices=false',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text'
        };
        return this.send(options);
    },
    deletePaymentMethod: function (pmId, forceDefaultPmDeletion, deleteDefaultPmWithAutoPayOff) {
        var options = {
            type: "DELETE",
            url: '/rest/v1/paymentMethods/' + pmId +
            '?forceDefaultPmDeletion=' + forceDefaultPmDeletion + '&deleteDefaultPmWithAutoPayOff=' + deleteDefaultPmWithAutoPayOff,
            dataType: 'text'
        };
        return this.send(options);
    },
    setDefaultPaymentMethod: function (accountId, pmId, payAllUnpaidInvoices) {
        if (!payAllUnpaidInvoices) {
            payAllUnpaidInvoices = false;
        } else {
            payAllUnpaidInvoices = true;
        }
        var options = {
            type: "PUT",
            url: '/rest/v1/accounts/' + accountId + '/paymentMethods/' + pmId + '/setDefault?payAllUnpaidInvoices=' + payAllUnpaidInvoices,
            contentType: "application/json",
            dataType: 'text'
        };
        return this.send(options);
    },
    createAccountPayment: function (account_id, pmId, data) {
        var url;
        if (pmId) {
            url = '/rest/v1/accounts/' + account_id + '/payments?paymentMethodId=' + pmId;
        } else {
            url = '/rest/v1/accounts/' + account_id + '/payments';
        }
        var getPaymentId = function (response, xhr) {
            var locationHeader = xhr ? xhr.getResponseHeader('Location') : null;
            if (locationHeader && locationHeader.length > 0) {
                return {
                    paymentId: locationHeader.substring(locationHeader.lastIndexOf('payments/') + 9)
                }
            } else {
                return {
                    error: response.responseText
                }
            }
        };
        var options = {
            type: "POST",
            url: url,
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text',
            resolve: function (response, status, xhr) {
                return getPaymentId(response, xhr);
            },
            reject: function (response, status, errorThrown) {
                return getPaymentId(response);
            }
        };
        return this.send(options);
    },
    capturePayment: function (data) {
        var getPaymentId = function (response, xhr) {
            var locationHeader = xhr ? xhr.getResponseHeader('Location') : null;
            if (locationHeader && locationHeader.length > 0) {
                return {
                    paymentId: locationHeader.substring(locationHeader.lastIndexOf('payments/') + 9)
                }
            } else {
                return {
                    error: response.responseText
                }
            }
        };
        var options = {
            type: "POST",
            url: '/rest/v1/payments',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text',
            resolve: function (response, status, xhr) {
                return getPaymentId(response, xhr);
            },
            reject: function (response, status, errorThrown) {
                return getPaymentId(response);
            }
        };
        return this.send(options);
    },
    chargebackPayment: function (data) {
        var getPaymentId = function (response, xhr) {
            var locationHeader = xhr ? xhr.getResponseHeader('Location') : null;
            if (locationHeader && locationHeader.length > 0) {
                return {
                    paymentId: locationHeader.substring(locationHeader.lastIndexOf('payments/') + 9)
                }
            } else {
                return {
                    error: response.responseText
                }
            }
        };
        var options = {
            type: "POST",
            url: '/rest/v1/payments/chargebacks',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text',
            resolve: function (response, status, xhr) {
                return getPaymentId(response, xhr);
            },
            reject: function (response, status, errorThrown) {
                return getPaymentId(response);
            }
        };
        return this.send(options);
    },
    refundPayment: function (data) {
        var getPaymentId = function (response, xhr) {
            var locationHeader = xhr ? xhr.getResponseHeader('Location') : null;
            if (locationHeader && locationHeader.length > 0) {
                return {
                    paymentId: locationHeader.substring(locationHeader.lastIndexOf('payments/') + 9)
                }
            } else {
                return {
                    error: response.responseText
                }
            }
        };
        var options = {
            type: "POST",
            url: '/rest/v1/payments/refunds',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text',
            resolve: function (response, status, xhr) {
                return getPaymentId(response, xhr);
            },
            reject: function (response, status, errorThrown) {
                return getPaymentId(response);
            }
        };
        return this.send(options);
    },
    voidPayment: function (data) {
        var getPaymentId = function (response, xhr) {
            var locationHeader = xhr ? xhr.getResponseHeader('Location') : null;
            if (locationHeader && locationHeader.length > 0) {
                return {
                    paymentId: locationHeader.substring(locationHeader.lastIndexOf('payments/') + 9)
                }
            } else {
                return {
                    error: response.responseText
                }
            }
        };
        var options = {
            type: "DELETE",
            url: '/rest/v1/payments',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text',
            resolve: function (response, status, xhr) {
                return getPaymentId(response, xhr);
            },
            reject: function (response, status, errorThrown) {
                return getPaymentId(response);
            }
        };
        return this.send(options);
    },
    addCredit: function (data) {
        var options = {
            type: "POST",
            url: '/rest/v1/credits',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text',
            resolve: function (response, status, xhr) {
                var locationHeader = xhr.getResponseHeader('Location');
                return locationHeader.substring(locationHeader.lastIndexOf('/') + 1);
            }
        };
        return this.send(options);
    },
    addCharge: function (account_id, data) {
        var options = {
            type: "POST",
            url: '/rest/v1/invoices/charges/' + account_id + '?autoCommit=true',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'json'
        };
        return this.send(options);
    },
    getAccountBundles: function (account_id) {
        var options = {
            type: "GET",
            url: '/rest/v1/accounts/' + account_id + '/bundles',
            dataType: 'json'
        };
        return this.send(options);
    },
    changeSubscription: function (subscription_id, data, billingPolicy, requestedDate) {
        var url = '/rest/v1/subscriptions/' + subscription_id + '?callCompletion=false';
        if (billingPolicy) {
            url = url + '&billingPolicy=' + billingPolicy;
        }
        if (requestedDate) {
            url = url + '&requestedDate=' + requestedDate;
        }
        var options = {
            type: "PUT",
            url: url,
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'json'
        };
        return this.send(options);
    },
    createSubscription: function (data, requestedDate) {
        var url = '/rest/v1/subscriptions?callCompletion=false';
        if (requestedDate) {
            url = url + '&requestedDate=' + requestedDate;
        }
        var options = {
            type: "POST",
            url: url,
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text'
        };
        return this.send(options);
    },
    transferOwnership: function (bundle_id, data) {
        var options = {
            type: "PUT",
            url: '/rest/v1/bundles/' + bundle_id,
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'json'
        };
        return this.send(options);
    },
    updateSubscriptionBcd: function (subscription_id, data) {
        var options = {
            type: "PUT",
            url: '/rest/v1/subscriptions/' + subscription_id + '/bcd',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text'
        };
        return this.send(options);
    },
    cancelSubscription: function (subscription_id, billingPolicy, entitlementPolicy, useRequestedDateForBilling) {
        var url = '/rest/v1/subscriptions/' + subscription_id;
        if (useRequestedDateForBilling) {
            url = url + '?useRequestedDateForBilling=true'
        } else {
            url = url + '?useRequestedDateForBilling=false'
        }
        if (billingPolicy) {
            url = url + '&billingPolicy=' + billingPolicy;
        }
        if (entitlementPolicy) {
            url = url + '&entitlementPolicy=' + entitlementPolicy;
        }
        var options = {
            type: "DELETE",
            url: url,
            dataType: 'text'
        };
        return this.send(options);
    },
    unCancelSubscription: function (subscription_id) {
        var options = {
            type: "PUT",
            url: '/rest/v1/subscriptions/' + subscription_id + '/uncancel',
            contentType: "application/json",
            dataType: 'text'
        };
        return this.send(options);
    },
    getAccountInvoices: function (account_id) {
        var options = {
            type: "GET",
            url: '/rest/v1/accounts/' + account_id + '/invoices?withItems=true',
            dataType: 'json'
        };
        return this.send(options);
    },
    getInvoice: function (invoice_id) {
        var options = {
            type: "GET",
            url: '/rest/v1/invoices/' + invoice_id + '?withItems=true&audit=FULL',
            dataType: 'json'
        };
        return this.send(options);
    },
    createInvoiceCharge: function (account_id, data, requestedDate) {
        var url = '/rest/v1/invoices/charges/' + account_id + '?autoCommit=true';
        if (requestedDate && requestedDate.length > 0) {
            url = url + '&requestedDate=' + requestedDate;
        }
        var options = {
            type: "POST",
            url: url,
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'json'
        };
        return this.send(options);
    },

    createInvoicePayment: function (invoice_id, data) {
        var options = {
            type: "POST",
            url: '/rest/v1/invoices/' + invoice_id + '/payments?externalPayment=false',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text'
        };
        return this.send(options);
    },

    createInvoiceCredit: function (data) {
        var options = {
            type: "POST",
            url: '/rest/v1/credits?autoCommit=false',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text'
        };
        return this.send(options);
    },

    adjustInvoiceItem: function (invoice_id, data) {
        var options = {
            type: "POST",
            url: '/rest/v1/invoices/' + invoice_id,
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text'
        };
        return this.send(options);
    },

    getAccountPayments: function (account_id) {
        var options = {
            type: "GET",
            url: '/rest/v1/accounts/' + account_id + '/payments',
            dataType: 'json'
        };
        return this.send(options);
    },

    getPaymentsByInvoiceId: function (invoice_id) {
        var options = {
            type: "GET",
            url: '/rest/v1/invoices/' + invoice_id + '/payments?withAttempts=true&withPluginInfo=true&audit=FULL',
            dataType: 'json'
        };
        return this.send(options);
    },

    getInvoicePayments: function (payment_id) {
        var options = {
            type: "GET",
            url: '/rest/v1/invoicePayments/' + payment_id + '?withAttempts=true&withPluginInfo=true',
            dataType: 'json'
        };
        return this.send(options);
    },

    getPaymentMethod: function (payment_method_id) {
        var options = {
            type: "GET",
            url: '/rest/v1/paymentMethods/' + payment_method_id + '?withPluginInfo=true',
            dataType: 'json'
        };
        return this.send(options);
    },

    refundInvoicePayments: function (payment_id, data) {
        var options = {
            type: "POST",
            url: '/rest/v1/invoicePayments/' + payment_id + '/refunds',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text'
        };
        return this.send(options);
    },

    getPluginConfig: function (pluginName) {
        var options = {
            type: "GET",
            url: '/rest/v1/tenants/uploadPluginConfig/' + pluginName,
            dataType: 'json'
        };
        return this.send(options);
    },

    updatePluginConfig: function (pluginName, pluginData) {
        var options = {
            type: "POST",
            url: '/rest/v1/tenants/uploadPluginConfig/' + pluginName,
            data: pluginData,
            contentType: "text/plain",
            dataType: 'text'
        };
        return this.send(options);
    },
    deletePluginConfig: function (pluginName) {
        var options = {
            type: "DELETE",
            url: '/rest/v1/tenants/uploadPluginConfig/' + pluginName
        };
        return this.send(options);
    },
    getBundleSearch: function (searchKey, offset, limit) {
        var data = {
            offset: offset ? offset : 0,
            limit: limit ? limit : 100,
            audit: 'NONE'
        };
        var url = searchKey ? '/rest/v1/bundles/search/' + searchKey : '/rest/v1/bundles/pagination';
        var options = {
            type: "GET",
            url: url,
            dataType: 'json',
            data: data,
            resolve: function (response, status, xhr) {
                var total = parseInt(xhr.getResponseHeader('x-uengine-pagination-totalnbrecords'));
                var filtered = parseInt(xhr.getResponseHeader('x-uengine-pagination-maxnbrecords'));
                return {
                    data: response,
                    total: total,
                    filtered: filtered,
                    offset: data.offset,
                    limit: data.limit
                };
            }
        };
        return this.send(options);
    },
    getInvoiceSearch: function (searchKey, offset, limit) {
        var data = {
            offset: offset ? offset : 0,
            limit: limit ? limit : 100,
            withItems: false,
            audit: 'NONE'
        };
        var url = searchKey ? '/rest/v1/invoices/search/' + searchKey : '/rest/v1/invoices/pagination';
        var options = {
            type: "GET",
            url: url,
            dataType: 'json',
            data: data,
            resolve: function (response, status, xhr) {
                //x-uengine-pagination-maxnbrecords
                var total = parseInt(xhr.getResponseHeader('x-uengine-pagination-totalnbrecords'));
                var filtered = parseInt(xhr.getResponseHeader('x-uengine-pagination-maxnbrecords'));
                return {
                    data: response,
                    total: total,
                    filtered: filtered,
                    offset: data.offset,
                    limit: data.limit
                };
            }
        };
        return this.send(options);
    },
    getAccountTimeLine: function (account_id) {
        var options = {
            type: "GET",
            url: '/rest/v1/accounts/' + account_id + '/timeline?audit=FULL&parallel=false',
            dataType: 'json'
        };
        return this.send(options);
    },

    getNotificationConfig: function () {
        var options = {
            type: "GET",
            url: '/rest/v1/notification_config',
            dataType: 'json'
        };
        return this.send(options);
    },
    updateNotificationConfig: function (data) {
        var options = {
            type: "POST",
            url: '/rest/v1/notification_config',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text'
        };
        return this.send(options);
    },

    getAllTemplate: function () {
        var options = {
            type: "GET",
            url: '/rest/v1/template',
            dataType: 'json'
        };
        return this.send(options);
    },

    createTemplate: function (template_type, locale, data) {
        var options = {
            type: "POST",
            url: '/rest/v1/template/' + template_type + '/' + locale,
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'text'
        };
        return this.send(options);
    },

    deleteTemplate: function (template_type, locale) {
        var options = {
            type: "DELETE",
            url: '/rest/v1/template/' + template_type + '/' + locale
        };
        return this.send(options);
    },

    setDefaultTemplate: function (template_type, locale) {
        var options = {
            type: "PUT",
            url: '/rest/v1/template/' + template_type + '/' + locale,
            dataType: 'text'
        };
        return this.send(options);
    },

    getAccountOneTimeBuys: function (account_id) {
        var options = {
            type: "GET",
            url: '/rest/v1/accounts/' + account_id + '/onetimebuy',
            dataType: 'json'
        };
        return this.send(options);
    },
    createOneTimeBuy: function (data, accountId, requestedDate) {
        var url = '/rest/v1/onetimebuy?accountId=' + accountId;
        if (requestedDate) {
            url = url + '&requestedDate=' + requestedDate;
        }
        var options = {
            type: "POST",
            url: url,
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'json'
        };
        return this.send(options);
    },
    cancelOneTimeBuy: function (record_id) {
        var url = '/rest/v1/onetimebuy/' + record_id;
        var options = {
            type: "DELETE",
            url: url,
            dataType: 'json'
        };
        return this.send(options);
    },

    getOrgSalesHistories: function (searchKey, offset, limit) {
        var data = {
            offset: offset ? offset : 0,
            limit: limit ? limit : 100
        };
        var url = searchKey ? '/rest/v1/organization/sales/search/' + searchKey : '/rest/v1/organization/sales/pagination';
        var options = {
            type: "GET",
            url: url,
            dataType: 'json',
            data: data,
            resolve: function (response, status, xhr) {
                var total = parseInt(xhr.getResponseHeader('x-uengine-pagination-totalnbrecords'));
                var filtered = parseInt(xhr.getResponseHeader('x-uengine-pagination-maxnbrecords'));
                return {
                    data: response,
                    total: total,
                    filtered: filtered,
                    offset: data.offset,
                    limit: data.limit
                };
            }
        };
        return this.send(options);
    },
    getAccountSalesHistories: function (id, searchKey, offset, limit) {
        var data = {
            offset: offset ? offset : 0,
            limit: limit ? limit : 100
        };
        var url = searchKey ? '/rest/v1/accounts/' + id + '/sales/search/' + searchKey : '/rest/v1/accounts/' + id + '/sales/pagination';
        var options = {
            type: "GET",
            url: url,
            dataType: 'json',
            data: data,
            resolve: function (response, status, xhr) {
                var total = parseInt(xhr.getResponseHeader('x-uengine-pagination-totalnbrecords'));
                var filtered = parseInt(xhr.getResponseHeader('x-uengine-pagination-maxnbrecords'));
                return {
                    data: response,
                    total: total,
                    filtered: filtered,
                    offset: data.offset,
                    limit: data.limit
                };
            }
        };
        return this.send(options);
    },
    getProductSalesHistories: function (id, searchKey, offset, limit) {
        var data = {
            offset: offset ? offset : 0,
            limit: limit ? limit : 100
        };
        var url = searchKey ? '/rest/v1/product/' + id + '/sales/search/' + searchKey : '/rest/v1/product/' + id + '/sales/pagination';
        var options = {
            type: "GET",
            url: url,
            dataType: 'json',
            data: data,
            resolve: function (response, status, xhr) {
                var total = parseInt(xhr.getResponseHeader('x-uengine-pagination-totalnbrecords'));
                var filtered = parseInt(xhr.getResponseHeader('x-uengine-pagination-maxnbrecords'));
                return {
                    data: response,
                    total: total,
                    filtered: filtered,
                    offset: data.offset,
                    limit: data.limit
                };
            }
        };
        return this.send(options);
    },
    getOrgSalesSummary: function (period, start_date, end_date, vendor_id, product_id, plan_name, usage_name) {
        var data = {
            period: period,
            start_date: start_date,
            end_date: end_date,
            vendor_id: vendor_id,
            product_id: product_id,
            plan_name: plan_name,
            usage_name: usage_name
        };
        var options = {
            type: "GET",
            url: '/rest/v1/organization/sales/summary',
            dataType: 'json',
            data: data
        };
        return this.send(options);
    },
    getProductSalesSummary: function (id, period, start_date, end_date, vendor_id, product_id, plan_name, usage_name) {
        var data = {
            period: period,
            start_date: start_date,
            end_date: end_date,
            vendor_id: vendor_id,
            product_id: product_id,
            plan_name: plan_name,
            usage_name: usage_name
        };
        var options = {
            type: "GET",
            url: '/rest/v1/product/' + id + '/sales/summary',
            dataType: 'json',
            data: data
        };
        return this.send(options);
    },
    getAccountSalesSummary: function (id, period, start_date, end_date, vendor_id, product_id, plan_name, usage_name) {
        var data = {
            period: period,
            start_date: start_date,
            end_date: end_date,
            vendor_id: vendor_id,
            product_id: product_id,
            plan_name: plan_name,
            usage_name: usage_name
        };
        var options = {
            type: "GET",
            url: '/rest/v1/accounts/' + id + '/sales/summary',
            dataType: 'json',
            data: data
        };
        return this.send(options);
    },
    getAccountSalesBalance: function (id) {
        var options = {
            type: "GET",
            url: '/rest/v1/accounts/' + id + '/sales/balance',
            dataType: 'json'
        };
        return this.send(options);
    },
    createAccountWithdraw: function (id, data) {
        var options = {
            type: "POST",
            url: '/rest/v1/accounts/' + id + '/sales/withdraw',
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: 'json'
        };
        return this.send(options);
    },
    cancelWithdraw: function (account_id, record_id) {
        var options = {
            type: "DELETE",
            url: '/rest/v1/accounts/' + account_id + '/sales/cancelwithdraw/' + record_id
        };
        return this.send(options);
    },
    updateSalesNotes: function (account_id, record_id, notes) {
        var options = {
            type: "PUT",
            url: '/rest/v1/accounts/' + account_id + '/sales/notes/' + record_id,
            data: JSON.stringify({notes: notes}),
            contentType: "application/json",
            dataType: 'json'
        };
        return this.send(options);
    },
    unblockAccount: function (account_id, resumeInvoice) {
        var url = '/rest/v1/accounts/' + account_id + '/unblock';
        url = resumeInvoice ? url + '?resumeInvoice=true' : url;
        var options = {
            type: "PUT",
            url: url,
            dataType: 'text'
        };
        return this.send(options);
    },
    blockAccount: function (account_id, blockJson) {
        var options = {
            type: "PUT",
            url: '/rest/v1/accounts/' + account_id + '/block',
            data: JSON.stringify(blockJson),
            contentType: "application/json",
            dataType: 'text'
        };
        return this.send(options);
    },

    send: function (options) {
        var caller = arguments.callee.caller.name;
        var me = this;
        var deferred = $.Deferred();
        var ajaxOptions = {
            type: options.type,
            url: me.baseUrl + options.url
        };
        if (options.dataType) {
            ajaxOptions.dataType = options.dataType;
        }
        if (options.contentType) {
            ajaxOptions.contentType = options.contentType;
        }
        if (options.async) {
            ajaxOptions.async = options.async;
        }
        if (options.data) {
            ajaxOptions.data = options.data;
        }
        var promise = $.ajax(ajaxOptions);
        promise.done(function (response, status, xhr) {
            console.log(caller + ' success');
            if (options.resolve) {
                response = options.resolve(response, status, xhr);
            }
            deferred.resolve(response);
        });
        promise.fail(function (response, status, errorThrown) {
            console.log(caller + ' failed');
            console.log(response, status, errorThrown);
            if (options.reject) {
                response = options.reject(response, status, errorThrown);
            }
            deferred.reject(response);
        });
        return deferred.promise();
    }
}
;
uBilling.prototype.constructor = uBilling;
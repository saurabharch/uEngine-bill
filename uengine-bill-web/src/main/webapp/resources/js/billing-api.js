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
            console.log('validateToken success');
            deferred.resolve(response);
        });
        promise.fail(function (response, status, errorThrown) {
            console.log('validateToken failed', errorThrown, response.responseText);
            deferred.reject(response);
        });
        return deferred.promise();
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
    getAccount: function (accountId) {
        var options = {
            type: "GET",
            url: '/rest/v1/accounts/' + accountId,
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
                //x-killbill-pagination-maxnbrecords
                var total = parseInt(xhr.getResponseHeader('x-killbill-pagination-totalnbrecords'));
                var filtered = parseInt(xhr.getResponseHeader('x-killbill-pagination-maxnbrecords'));
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
    send: function (options) {
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
            console.log('getOrganizationEmails success');
            if (options.resolve) {
                response = options.resolve(response, status, xhr);
            }
            deferred.resolve(response);
        });
        promise.fail(function (response, status, errorThrown) {
            console.log(response, status, errorThrown);
            //console.log('getOrganizationEmails failed', errorThrown, response.responseText);
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
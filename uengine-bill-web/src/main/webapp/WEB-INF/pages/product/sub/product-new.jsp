<%@ page contentType="text/html; charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>
<div class="modal inmodal fade" id="product-new-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title" data-i18n="product.new.title">New Product</h4>
            </div>
            <div class="modal-body">
                <div class="ibox float-e-margins">
                    <div class="ibox-content no-padding">
                        <form method="get" class="form-horizontal">
                            <div class="form-group"><label class="col-sm-2 control-label" data-i18n="product.new.name">Name</label>

                                <div class="col-sm-10"><input type="text" class="form-control" name="name">
                                </div>
                            </div>
                            <div class="form-group onNew"><label class="col-sm-2 control-label"
                                                                 data-i18n="product.new.category">Category</label>
                                <div class="col-sm-5">
                                    <select class="chosen-select" name="category" required>
                                        <option value="BASE" selected data-i18n="product.new.base">BASE</option>
                                        <option value="ADD_ON" data-i18n="product.new.addon">ADD_ON</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group onUpdate"><label class="col-sm-2 control-label"
                                                                    data-i18n="product.new.category">Category</label>
                                <div class="col-sm-5">
                                    <input type="text" class="form-control" readonly value="ADD_ON">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label"
                                       data-i18n="product.new.description">Description</label>
                                <div class="col-sm-10">
                                    <textarea class="form-control" name="description"></textarea>
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-2 control-label"
                                                           data-i18n="product.new.redirect">Redirect url</label>

                                <div class="col-sm-10">
                                    <input type="text" class="form-control" name="redirect_url">
                                    <small class="text-muted" data-i18n="product.new.redirectInfo">
                                        A redirect url is an address that a buyer completes a purchase through a hosted
                                        page and is redirected with the result of the purchase action. Usually you will
                                        use the seller's application address.
                                    </small>
                                </div>
                            </div>

                            <div name="active" class="form-group">
                                <label class="col-sm-2 control-label"></label>
                                <div class="col-sm-10">
                                    <span name="is_active" class="label label-primary">Active</span>
                                    <a name="mark_as">Mark as Inactive</a>
                                    <br>
                                    <small class="text-muted" data-i18n="product.new.inactiveInfo">
                                        If in the Inactive state, you customer will not be able to subscribe or change a
                                        product, but your existing purchasing customer will remain in service.
                                    </small>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">
                                    <span data-i18n="product.new.vendor">Vendor </span>
                                    <a href="Javascript:void(0)" name="vendor-add">+ add</a>
                                </label>

                                <div class="col-sm-10" name="vendor-item-list">

                                </div>
                            </div>
                        </form>

                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-white" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" name="save">Save</button>
            </div>
        </div>
    </div>
</div>

<div style="display: none">
    <div id="vendor-item" name="vendor-item" class="row">
        <div class="col-sm-7" style="padding-right: 0">
            <small class="text-muted">Vendor</small>
            <select class="chosen-select" tabindex="2" name="account_id" required>
                <option value=""></option>
            </select>
        </div>
        <div class="col-sm-3" style="padding: 0">
            <small class="text-muted">Ratio (%)</small>
            <input name="ratio" type="number" step="0.01" min="0" class="form-control" value="">
        </div>
        <div class="col-sm-2">
            <small>&nbsp;</small>
            <br>
            <a class="fa fa-trash-o" name="delete"> del</a>
        </div>
    </div>
</div>

<script>
    var productController = {
        isFist: true,
        modal: null,
        form: null,
        product_id: null,
        trigger: null,
        open: function (product_id, trigger) {
            var me = this;
            if (this.isFist) {
                this.trigger = trigger;
                this.modal = $('#product-new-modal');
                this.form = this.modal.find('form');
                this.form.find('.chosen-select').chosen({width: "100%"});
            }
            this.modal.find('[name=save]').unbind('click');
            this.modal.find('[name=save]').click(function () {
                me.save();
            });
            if (!product_id) {
                this.product_id = null;
                this.reset();
                this.modal.modal('show');
                this.form.find('.onNew').show();
                this.form.find('.onUpdate').hide();
                this.modal.find('.modal-title').html('New Product');
                this.mark();
                me.setVendor();
            } else {
                this.product_id = product_id;
                uBilling.getProduct(product_id)
                    .done(function (product) {
                        me.form.deserialize(product);
                        me.form.find('.chosen-select').trigger("chosen:updated");
                        me.modal.modal('show');
                        me.form.find('.onNew').hide();
                        me.form.find('.onUpdate').show();
                        me.form.find('.onUpdate').find('input').val(product.category);
                        me.modal.find('.modal-title').html('Edit Product');
                        me.mark(product);
                        me.setVendor(product);
                    })
                    .fail(function () {
                        toastr.error("Failed to get product information.");
                    })
            }
        },
        setVendor: function (product) {
            var me = this;
            var appender = me.form.find('[name=vendor-item-list]');
            var addBtn = me.form.find('[name=vendor-add]');
            appender.find('[name=vendor-item]').remove();

            var addVendor = function (vendor, accounts) {
                var item = $('#vendor-item').clone();
                item.removeAttr('id');
                item.find('[name=delete]').click(function () {
                    item.remove();
                })
                appender.append(item);

                var accountSelect = item.find('[name=account_id]');
                var ratio = item.find('[name=ratio]');
                accountSelect.chosen({width: "100%"});
                if (vendor) {
                    var account_id = vendor['account_id'];
                    var account;
                    for (var i in accounts) {
                        if (accounts[i]['id'] == account_id) {
                            account = accounts[i];
                        }
                    }
                    if (account) {
                        ratio.val(vendor.ratio);
                        accountSelect.append('<option selected value="' + account['id'] + '">' + account['name'] + '</option>');
                        accountSelect.trigger("chosen:updated");
                    }
                }

                accountSelect.parent().find('input').autocomplete({
                    source: function (request, response) {
                        accountSelect.find('option').remove();
                        accountSelect.append('<option></option>');
                        uBilling.getAccountSearch(request.term, 0, 10)
                            .done(function (accounts) {
                                for (var i = 0; i < accounts['data'].length; i++) {
                                    var account = accounts['data'][i];
                                    accountSelect.append('<option value="' + account['accountId'] + '">' + account['name'] + '</option>');
                                }
                            })
                            .always(function () {
                                accountSelect.trigger("chosen:updated");
                                accountSelect.parent().find('input').val(request.term);
                            })
                    }
                });
            }
            addBtn.unbind('click').bind('click', function () {
                addVendor();
            });

            if (product && product.vendors) {
                var ids = [];
                $.each(product.vendors, function (index, vendor) {
                    ids.push(vendor['account_id']);
                });
                uBilling.getAccountIds(ids)
                    .done(function (accounts) {
                        $.each(product.vendors, function (index, vendor) {
                            addVendor(vendor, accounts);
                        })
                    })
            }
        },
        getVendor: function () {
            var me = this;
            var vendors = [];
            me.form.find('[name=vendor-item]').each(function () {
                var item = $(this);
                var account_id = item.find('[name=account_id]').val();
                var ratio = item.find('[name=ratio]').val();
                if (account_id && account_id.length > 0 && ratio) {
                    vendors.push({
                        account_id: account_id,
                        ratio: ratio
                    })
                }
            })
            return vendors;
        },
        reset: function () {
            this.form[0].reset();
            this.form.find('.chosen-select').trigger("chosen:updated");
        },
        save: function () {
            var me = this;
            var product_id = me.product_id;
            if (product_id) {
                var data = me.form.serializeObject();
                data.vendors = me.getVendor();
                uBilling.updateProduct(product_id, data)
                    .done(function (product) {
                        toastr.success("Product updated.");
                        if (me.trigger) {
                            me.trigger.trigger("updated");
                        }
                        me.modal.modal('hide');
                    })
                    .fail(function () {
                        toastr.error("Failed to update product.");
                    });
            } else {
                var data = me.form.serializeObject();
                data.vendors = me.getVendor();
                uBilling.createProduct(data)
                    .done(function (product_id) {
                        window.location.href = '/product/' + product_id + '/version/current/detail';
                    })
                    .fail(function () {
                        toastr.error("Failed to create product.");
                    });
            }
        },
        mark: function (product) {
            var me = this;
            if (!product) {
                me.modal.find('[name=active]').hide();
                return;
            }
            me.modal.find('[name=active]').show();
            var mark_as = me.modal.find('[name=mark_as]');
            var is_active = me.modal.find('[name=is_active]');
            mark_as.unbind('click');

            if (product['is_active'] == 'Y') {
                is_active.removeClass('label-warning');
                is_active.addClass('label-primary');
                is_active.html('Active');
                mark_as.html('Mark as Inactive');
                mark_as.bind('click', function () {
                    me.updateActive('N');
                })
            } else {
                is_active.removeClass('label-primary');
                is_active.addClass('label-warning');
                is_active.html('Inactive');
                mark_as.html('Mark as Active');
                mark_as.bind('click', function () {
                    me.updateActive('Y');
                })
            }
        },
        updateActive: function (is_active) {
            var me = this;
            var data = {
                'is_active': is_active
            };
            uBilling.updateProductActive(me.product_id, data)
                .done(function (product) {
                    toastr.success("Product updated as " + (is_active == 'Y' ? 'Active' : 'Inactive'));
                    if (me.trigger) {
                        me.trigger.trigger("updated");
                    }
                    me.mark(product);
                })
                .fail(function () {
                    toastr.error("Failed to update product  as " + (is_active == 'Y' ? 'Active' : 'Inactive'));
                });
        }
    };
</script>
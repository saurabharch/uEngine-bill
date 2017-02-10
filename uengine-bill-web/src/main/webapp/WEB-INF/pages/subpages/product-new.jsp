<div class="modal inmodal fade" id="product-new-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title">New Product</h4>
            </div>
            <div class="modal-body">
                <div class="ibox float-e-margins">
                    <div class="ibox-content no-padding">
                        <form method="get" class="form-horizontal">
                            <div class="form-group"><label class="col-sm-2 control-label">Name</label>

                                <div class="col-sm-10"><input type="text" class="form-control" name="name">
                                </div>
                            </div>
                            <div class="form-group onNew"><label class="col-sm-2 control-label">Category</label>
                                <div class="col-sm-5">
                                    <select class="chosen-select" name="category" required>
                                        <option value="BASE" selected>BASE</option>
                                        <option value="ADD_ON">ADD_ON</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group onUpdate"><label class="col-sm-2 control-label">Category</label>
                                <div class="col-sm-5">
                                    <input type="text" class="form-control" readonly value="ADD_ON">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Description</label>
                                <div class="col-sm-10">
                                    <textarea class="form-control" name="description"></textarea>
                                </div>
                            </div>
                            <div class="form-group"><label class="col-sm-2 control-label">Redirect url</label>

                                <div class="col-sm-10"><input type="text" class="form-control" name="redirect_url">
                                </div>
                            </div>

                            <div name="active" class="form-group">
                                <label class="col-sm-2 control-label"></label>
                                <div class="col-sm-10">
                                    <span name="is_active" class="label label-primary">Active</span>
                                    <a name="mark_as">Mark as Inactive</a>
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
                    })
                    .fail(function () {
                        toastr.error("Failed to get product information.");
                    })
            }
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
    //conditionKeyBox.val(conditionKey).trigger("chosen:updated");
    //var data = $(this).serializeObject();
    //$('form').deserialize(currentOrg);
    //toastr.success("Billing rule updated.")
</script>
alter table killbill.accounts add column billing_cycle_day_local_ext int(11) DEFAULT NULL after billing_cycle_day_local;

DROP TABLE IF EXISTS organization;
CREATE TABLE organization (
    id VARCHAR(36) NOT NULL,
    name VARCHAR(256) NOT NULL,
    tenant_id VARCHAR(36) NOT NULL,
    tenant_external_key VARCHAR(255) NULL,
    tenant_api_key VARCHAR(128) NULL,
    tenant_api_secret VARCHAR(128) NULL,
    tenant_api_salt VARCHAR(128) NULL,
    fax VARCHAR(255) NULL,
    website VARCHAR(255) NULL,
    language_code VARCHAR(10) NULL,
    time_zone VARCHAR(125) NULL,
    date_format VARCHAR(128) NULL,
    currency varchar(3) DEFAULT NULL,
    is_active CHAR(1) DEFAULT 'Y',
    address1 varchar(100) DEFAULT NULL,
    address2 varchar(100) DEFAULT NULL,
    company_name varchar(256) DEFAULT NULL,
    city varchar(50) DEFAULT NULL,
    state_or_province varchar(50) DEFAULT NULL,
    country varchar(50) DEFAULT NULL,
    postal_code varchar(16) DEFAULT NULL,
    phone varchar(25) DEFAULT NULL,
    notes varchar(4096) DEFAULT NULL,
    reg_dt            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
)
  ENGINE=InnoDB
  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS authority;
CREATE TABLE authority (
    id VARCHAR(36) NOT NULL,
    organization_id VARCHAR(36) NOT NULL,
    user_id VARCHAR(36) NOT NULL,
    user_name VARCHAR(128) NOT NULL,
    role VARCHAR(36) NOT NULL,
    reg_dt            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
)
  ENGINE=InnoDB
  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS organization_email;
CREATE TABLE organization_email (
    id VARCHAR(36) NOT NULL,
    organization_id VARCHAR(36) NOT NULL,
    email varchar(128) NOT NULL,
    is_active CHAR(1) DEFAULT 'Y',
    is_default CHAR(1) DEFAULT 'N',
    reg_dt            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
)
  ENGINE=InnoDB
  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS billing_rule;
CREATE TABLE billing_rule (
    organization_id VARCHAR(36) NOT NULL,
    tenant_id VARCHAR(36) NOT NULL,
    rule LONGTEXT DEFAULT NULL,
    reg_dt            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(organization_id)
)
  ENGINE=InnoDB
  DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS product;
CREATE TABLE product (
    record_id INT(11) NOT NULL AUTO_INCREMENT,
    id VARCHAR(36),
    name VARCHAR(256) NOT NULL,
    category VARCHAR(12) DEFAULT 'BASE',
    owner_account_id VARCHAR(36),
    description VARCHAR(4096),
    redirect_url varchar(256),
    organization_id VARCHAR(36),
    tenant_id VARCHAR(36),
    is_active CHAR(1) DEFAULT 'Y',
    plan_seq INT(11) DEFAULT 0,
    usage_seq INT(11) DEFAULT 0,
    reg_dt            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(record_id)
)
  ENGINE=InnoDB
  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS product_version;
CREATE TABLE product_version (
    id INT(11) NOT NULL AUTO_INCREMENT,
    product_id VARCHAR(36) NOT NULL,
    version INT(11) DEFAULT 1 NOT NULL,
    effective_date TIMESTAMP NOT NULL,
    is_current CHAR(1) DEFAULT 'N',
    organization_id VARCHAR(36),
    tenant_id VARCHAR(36),
    plans LONGTEXT,
    reg_dt            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
)
  ENGINE=InnoDB
  DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS subscription_events_ext;
CREATE TABLE subscription_events_ext (
    id INT(11) NOT NULL AUTO_INCREMENT,
    subscription_id VARCHAR(36) NOT NULL,
    event_type VARCHAR(15),
    user_type VARCHAR(25) NOT NULL,
    plan_name VARCHAR(36) NOT NULL,
    product_id VARCHAR(36) NOT NULL,
    version INT(11) DEFAULT 1 NOT NULL,
    account_id VARCHAR(36) NOT NULL,
    organization_id VARCHAR(36) NOT NULL,
    tenant_id VARCHAR(36) NOT NULL,
    account_record_id BIGINT(20) NOT NULL,
    tenant_record_id BIGINT(20) NOT NULL,
    reg_dt            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
)
  ENGINE=InnoDB
  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS product_provider;
CREATE TABLE product_provider (
    id VARCHAR(36) NOT NULL,
    product_id VARCHAR(36) NOT NULL,
    account_id VARCHAR(36) NOT NULL,
    organization_id VARCHAR(36),
    tenant_id VARCHAR(36),
    account_record_id BIGINT(20),
    tenant_record_id BIGINT(20),
    distribution DECIMAL(15,9) DEFAULT 0,
    reg_dt            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
)
  ENGINE=InnoDB
  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS product_distribution_history;
CREATE TABLE product_distribution_history (
    id VARCHAR(36) NOT NULL,
    plan_name VARCHAR(36) NOT NULL,
    product_id VARCHAR(36) NOT NULL,
    version INT(11) DEFAULT 1 NOT NULL,
    usage_id VARCHAR(36) NOT NULL,
    account_id VARCHAR(36) NOT NULL,
    organization_id VARCHAR(36),
    tenant_id VARCHAR(36),
    account_record_id BIGINT(20),
    tenant_record_id BIGINT(20),
    distribution DECIMAL(15,9) DEFAULT 0,
    amount DECIMAL(15,9),
    original_amount DECIMAL(15,9),
    currency VARCHAR(3),
    invoice_id VARCHAR(36),
    payment_id VARCHAR(36),
    transaction_type VARCHAR(32),
    reg_dt            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
)
  ENGINE=InnoDB
  DEFAULT CHARSET=utf8;






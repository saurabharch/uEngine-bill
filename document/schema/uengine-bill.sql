ALTER TABLE killbill.accounts
  ADD COLUMN billing_cycle_day_local_ext INT(11) DEFAULT NULL
  AFTER billing_cycle_day_local;

CREATE TABLE IF NOT EXISTS registe (
  id           INT(11)      NOT NULL AUTO_INCREMENT,
  user_id      VARCHAR(36)  NOT NULL,
  token        VARCHAR(255) NOT NULL,
  registration TIMESTAMP             DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY (token),
  PRIMARY KEY (id)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS organization (
  id                  VARCHAR(36)  NOT NULL,
  name                VARCHAR(256) NOT NULL,
  tenant_id           VARCHAR(36)  NOT NULL,
  tenant_external_key VARCHAR(255) NULL,
  tenant_api_key      VARCHAR(128) NULL,
  tenant_api_secret   VARCHAR(128) NULL,
  tenant_api_salt     VARCHAR(128) NULL,
  fax                 VARCHAR(255) NULL,
  website             VARCHAR(255) NULL,
  language_code       VARCHAR(10)  NULL,
  time_zone           VARCHAR(125) NULL,
  date_format         VARCHAR(128) NULL,
  currency            VARCHAR(3)    DEFAULT NULL,
  is_active           CHAR(1)       DEFAULT 'Y',
  address1            VARCHAR(100)  DEFAULT NULL,
  address2            VARCHAR(100)  DEFAULT NULL,
  company_name        VARCHAR(256)  DEFAULT NULL,
  city                VARCHAR(50)   DEFAULT NULL,
  state_or_province   VARCHAR(50)   DEFAULT NULL,
  country             VARCHAR(50)   DEFAULT NULL,
  postal_code         VARCHAR(16)   DEFAULT NULL,
  phone               VARCHAR(25)   DEFAULT NULL,
  notes               VARCHAR(4096) DEFAULT NULL,
  reg_dt              TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS authority (
  id              VARCHAR(36)  NOT NULL,
  organization_id VARCHAR(36)  NOT NULL,
  user_id         VARCHAR(36)  NOT NULL,
  user_name       VARCHAR(128) NOT NULL,
  role            VARCHAR(36)  NOT NULL,
  reg_dt          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS organization_email (
  id              VARCHAR(36)  NOT NULL,
  organization_id VARCHAR(36)  NOT NULL,
  email           VARCHAR(128) NOT NULL,
  is_active       CHAR(1)   DEFAULT 'Y',
  is_default      CHAR(1)   DEFAULT 'N',
  reg_dt          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS organization_template (
  record_id         INT(11)      NOT NULL AUTO_INCREMENT,
  organization_id   VARCHAR(36)  NOT NULL,
  tenant_id         VARCHAR(36)  NOT NULL,
  tenant_record_id  BIGINT(20)   NOT NULL,
  notification_type VARCHAR(36)  NOT NULL,
  locale            VARCHAR(256) NOT NULL,
  is_default        CHAR(1)               DEFAULT 'N',
  subject           LONGTEXT,
  body              LONGTEXT,
  reg_dt            TIMESTAMP             DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (record_id)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS notification_config (
  record_id        INT(11)       NOT NULL AUTO_INCREMENT,
  organization_id  VARCHAR(36)   NOT NULL,
  tenant_id        VARCHAR(36)   NOT NULL,
  tenant_record_id BIGINT(20)    NOT NULL,
  configuration    VARCHAR(4096) NOT NULL,
  reg_dt           TIMESTAMP              DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (record_id)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS billing_rule (
  organization_id VARCHAR(36) NOT NULL,
  tenant_id       VARCHAR(36) NOT NULL,
  rule            LONGTEXT  DEFAULT NULL,
  reg_dt          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (organization_id)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS product (
  record_id        INT(11)      NOT NULL AUTO_INCREMENT,
  id               VARCHAR(36),
  name             VARCHAR(256) NOT NULL,
  category         VARCHAR(12)           DEFAULT 'BASE',
  owner_account_id VARCHAR(36),
  description      VARCHAR(4096),
  redirect_url     VARCHAR(256),
  organization_id  VARCHAR(36),
  tenant_id        VARCHAR(36),
  is_active        CHAR(1)               DEFAULT 'Y',
  plan_seq         INT(11)               DEFAULT 0,
  usage_seq        INT(11)               DEFAULT 0,
  reg_dt           TIMESTAMP             DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (record_id)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

ALTER TABLE product
  ADD vendors LONGTEXT;

CREATE TABLE IF NOT EXISTS product_version (
  id              INT(11)           NOT NULL AUTO_INCREMENT,
  product_id      VARCHAR(36)       NOT NULL,
  version         INT(11) DEFAULT 1 NOT NULL,
  effective_date  TIMESTAMP         NULL,
  organization_id VARCHAR(36),
  tenant_id       VARCHAR(36),
  plans           LONGTEXT,
  reg_dt          TIMESTAMP                  DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


CREATE TABLE IF NOT EXISTS subscription_events_ext (
  id                INT(11)           NOT NULL AUTO_INCREMENT,
  subscription_id   VARCHAR(36)       NULL,
  event_type        VARCHAR(15),
  user_type         VARCHAR(25)       NOT NULL,
  plan_name         VARCHAR(36)       NOT NULL,
  product_id        VARCHAR(36)       NOT NULL,
  version           INT(11) DEFAULT 1 NOT NULL,
  account_id        VARCHAR(36)       NOT NULL,
  organization_id   VARCHAR(36)       NOT NULL,
  tenant_id         VARCHAR(36)       NOT NULL,
  account_record_id BIGINT(20)        NOT NULL,
  tenant_record_id  BIGINT(20)        NOT NULL,
  reg_dt            TIMESTAMP                  DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;


CREATE TABLE IF NOT EXISTS product_distribution_history (
  record_id              INT(11)        NOT NULL AUTO_INCREMENT,
  subscription_id        VARCHAR(36)    NULL,
  tenant_id              VARCHAR(36)    NOT NULL,
  organization_id        VARCHAR(36)    NOT NULL,
  buyer_id               VARCHAR(36)    NULL,
  vendor_id              VARCHAR(36)    NULL,
  product_id             VARCHAR(36)    NULL,
  version                INT(11)        NULL,
  plan_name              VARCHAR(128)   NULL,
  usage_name             VARCHAR(128)   NULL,
  ratio                  NUMERIC(15, 9) NULL,
  amount                 NUMERIC(15, 9) NULL,
  original_amount        NUMERIC(15, 9) NULL,
  currency               VARCHAR(3)     NULL,
  invoice_id             VARCHAR(36)    NULL,
  invoice_item_id        VARCHAR(36)    NULL,
  linked_invoice_item_id VARCHAR(36)    NULL,
  invoice_item_type      VARCHAR(24)    NULL,
  price_type             VARCHAR(24)    NULL,
  transaction_type       VARCHAR(24)    NULL,
  format_date            VARCHAR(36)    NULL,
  created_date           TIMESTAMP      NULL,
  notes                  LONGTEXT                DEFAULT NULL,
  PRIMARY KEY (record_id)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

CREATE TABLE IF NOT EXISTS onetimebuy (
  record_id         INT(11)        NOT NULL AUTO_INCREMENT,
  bundle_id         VARCHAR(36)    NULL,
  state             VARCHAR(36)    NOT NULL,
  tenant_id         VARCHAR(36)    NOT NULL,
  organization_id   VARCHAR(36)    NOT NULL,
  account_id        VARCHAR(36)    NOT NULL,
  product_id        VARCHAR(36)    NOT NULL,
  version           INT(11)        NOT NULL,
  plan_name         VARCHAR(128)   NOT NULL,
  plan_display_name VARCHAR(128)   NOT NULL,
  amount            NUMERIC(15, 9) NOT NULL,
  currency          VARCHAR(3)     NOT NULL,
  invoice_id        VARCHAR(36)    NULL,
  invoice_item_id   VARCHAR(36)    NULL,
  effective_date    VARCHAR(36)    NOT NULL,
  billing_date      VARCHAR(36)    NOT NULL,
  created_date      TIMESTAMP      NOT NULL,
  PRIMARY KEY (record_id)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;






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
    reg_dt            TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
)
  ENGINE=InnoDB
  DEFAULT CHARSET=utf8;






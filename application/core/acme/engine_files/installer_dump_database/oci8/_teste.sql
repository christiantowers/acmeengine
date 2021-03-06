
-------------------------------------------------------
--  DDL for Table acm_user_group
--------------------------------------------------------
CREATE TABLE acm_user_group 
(	
	id_user_group NUMBER(10,0) NOT NULL, 
	name VARCHAR2(100 CHAR) NOT NULL, 
	description VARCHAR2(2000 CHAR), 
	dtt_inative DATE
);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index pk_acm_user_group
--------------------------------------------------------
CREATE UNIQUE INDEX pk_acm_user_group ON acm_user_group (id_user_group);


<<|SEPARATOR|>>
--------------------------------------------------------
--  Constraints for Table acm_user_group
--------------------------------------------------------
ALTER TABLE acm_user_group ADD CONSTRAINT pk_acm_user_group PRIMARY KEY (id_user_group) ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  Sequence for AUTO_INCREMENT
--------------------------------------------------------
CREATE SEQUENCE sq_acm_user_group MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 300 CACHE 20 NOORDER NOCYCLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Trigger for AUTO_INCREMENT
--------------------------------------------------------
CREATE OR REPLACE TRIGGER tgr_acm_user_group BEFORE INSERT ON acm_user_group
FOR EACH ROW
BEGIN
	IF :new.id_user_group IS NULL OR :new.id_user_group = 0 THEN
  		SELECT sq_acm_user_group.NEXTVAL
    		INTO :new.id_user_group
    	FROM DUAL;
    END IF;
END;


<<|SEPARATOR|>>
ALTER TRIGGER tgr_acm_user_group ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Table acm_user
--------------------------------------------------------
CREATE TABLE acm_user 
(	
	id_user NUMBER(10,0) NOT NULL, 
	id_user_group NUMBER(10,0) NOT NULL, 
	login VARCHAR2(250 CHAR) NOT NULL, 
	password VARCHAR2(2000 CHAR) NOT NULL, 
	name VARCHAR2(250 CHAR) NOT NULL, 
	email VARCHAR2(250 CHAR) NOT NULL, 
	description VARCHAR2(2000 CHAR), 
	dtt_inative DATE, 
	log_dtt_ins DATE DEFAULT SYSDATE
);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index fk_au_id_user_group
--------------------------------------------------------
CREATE INDEX fk_au_id_user_group ON acm_user (id_user_group);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index pk_acm_user
--------------------------------------------------------
CREATE UNIQUE INDEX pk_acm_user ON acm_user (id_user);


<<|SEPARATOR|>>
--------------------------------------------------------
--  Constraints for Table acm_user
--------------------------------------------------------
ALTER TABLE acm_user ADD CONSTRAINT pk_acm_user PRIMARY KEY (id_user) ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  Ref Constraints for Table acm_user
--------------------------------------------------------
ALTER TABLE acm_user ADD CONSTRAINT fk_au_id_user_group FOREIGN KEY (id_user_group) REFERENCES acm_user_group (id_user_group) ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  Sequence for AUTO_INCREMENT
--------------------------------------------------------
CREATE SEQUENCE sq_acm_user MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 300 CACHE 20 NOORDER NOCYCLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Trigger for AUTO_INCREMENT
--------------------------------------------------------
CREATE OR REPLACE TRIGGER tgr_acm_user BEFORE INSERT ON acm_user
FOR EACH ROW
BEGIN
	IF :new.id_user IS NULL OR :new.id_user = 0 THEN
  		SELECT sq_acm_user.NEXTVAL
    		INTO :new.id_user
    	FROM DUAL;
    END IF;
END;

<<|SEPARATOR|>>
ALTER TRIGGER tgr_acm_user ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Table acm_log
--------------------------------------------------------
CREATE TABLE acm_log 
(	
	id_log NUMBER(10,0) NOT NULL, 
	id_user NUMBER(10,0), 
	table_name VARCHAR2(50 CHAR), 
	action VARCHAR2(50 CHAR), 
	log_description VARCHAR2(2000 CHAR), 
	additional_data VARCHAR2(2000 CHAR), 
	user_agent VARCHAR2(2000 CHAR), 
	browser_name VARCHAR2(50 CHAR), 
	browser_version VARCHAR2(50 CHAR), 
	device_name VARCHAR2(100 CHAR), 
	device_version VARCHAR2(100 CHAR), 
	platform VARCHAR2(100 CHAR), 
	ip_address VARCHAR2(20 CHAR), 
	log_dtt_ins DATE DEFAULT SYSDATE
);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index fk_al_id_user
--------------------------------------------------------
CREATE INDEX fk_al_id_user ON acm_log (id_user);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index pk_acm_log
--------------------------------------------------------
CREATE UNIQUE INDEX pk_acm_log ON acm_log (id_log);


<<|SEPARATOR|>>
--------------------------------------------------------
--  Constraints for Table acm_log
--------------------------------------------------------
ALTER TABLE acm_log ADD CONSTRAINT pk_acm_log PRIMARY KEY (id_log) ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  Ref Constraints for Table acm_log
--------------------------------------------------------
ALTER TABLE acm_log ADD CONSTRAINT fk_al_id_user FOREIGN KEY (id_user) REFERENCES acm_user (id_user) ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  Sequence for AUTO_INCREMENT
--------------------------------------------------------
CREATE SEQUENCE sq_acm_log MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 300 CACHE 20 NOORDER NOCYCLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Trigger for AUTO_INCREMENT
--------------------------------------------------------
CREATE OR REPLACE TRIGGER tgr_acm_log BEFORE INSERT ON acm_log
FOR EACH ROW
BEGIN
	IF :new.id_log IS NULL OR :new.id_log = 0 THEN
  		SELECT sq_acm_log.NEXTVAL
    		INTO :new.id_log
    	FROM DUAL;
    END IF;
END;


<<|SEPARATOR|>>
ALTER TRIGGER tgr_acm_log ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Table acm_log_error
--------------------------------------------------------
CREATE TABLE acm_log_error 
(	
	id_log_error NUMBER(10,0) NOT NULL, 
	id_user NUMBER(10,0) NOT NULL, 
	error_type VARCHAR2(50 CHAR), 
	header VARCHAR2(2000 CHAR), 
	message VARCHAR2(2000 CHAR), 
	status_code VARCHAR2(10 CHAR),
	additional_data VARCHAR2(2000 CHAR), 
	user_agent VARCHAR2(2000 CHAR), 
	browser_name VARCHAR2(50 CHAR), 
	browser_version VARCHAR2(50 CHAR), 
	device_name VARCHAR2(100 CHAR), 
	device_version VARCHAR2(100 CHAR), 
	platform VARCHAR2(100 CHAR), 
	ip_address VARCHAR2(20 CHAR), 
	log_dtt_ins DATE DEFAULT SYSDATE
);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index fk_ale_id_user
--------------------------------------------------------
CREATE INDEX fk_ale_id_user ON acm_log_error (id_user);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index pk_acm_log_error
--------------------------------------------------------
CREATE UNIQUE INDEX pk_acm_log_error ON acm_log_error (id_log_error);


<<|SEPARATOR|>>
--------------------------------------------------------
--  Constraints for Table acm_log_error
--------------------------------------------------------
ALTER TABLE acm_log_error ADD CONSTRAINT pk_acm_log_error PRIMARY KEY (id_log_error);


<<|SEPARATOR|>>
--------------------------------------------------------
--  Ref Constraints for Table acm_log_error
--------------------------------------------------------
ALTER TABLE acm_log_error ADD CONSTRAINT fk_ale_id_user FOREIGN KEY (id_user) REFERENCES acm_user (id_user) ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  Sequence for AUTO_INCREMENT
--------------------------------------------------------
CREATE SEQUENCE sq_acm_log_error MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 300 CACHE 20 NOORDER NOCYCLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Trigger for AUTO_INCREMENT
--------------------------------------------------------
CREATE OR REPLACE TRIGGER tgr_acm_log_error BEFORE INSERT ON acm_log_error
FOR EACH ROW
BEGIN
	IF :new.id_log_error IS NULL OR :new.id_log_error = 0 THEN
  		SELECT sq_acm_log_error.NEXTVAL
    		INTO :new.id_log_error
    	FROM DUAL;
    END IF;
END;


<<|SEPARATOR|>>
ALTER TRIGGER tgr_acm_log_error ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Table acm_menu
--------------------------------------------------------
CREATE TABLE acm_menu 
(	
	id_menu NUMBER(10,0) NOT NULL, 
	id_menu_parent NUMBER(10,0), 
	id_user_group NUMBER(10,0) NOT NULL, 
	label VARCHAR2(250 CHAR), 
	link VARCHAR2(2000 CHAR), 
	target VARCHAR2(50 CHAR),  
	url_img VARCHAR2(2000 CHAR), 
	order_ NUMBER(10,0), 
	dtt_inative DATE
);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index pk_acm_menu
--------------------------------------------------------
CREATE UNIQUE INDEX pk_acm_menu ON acm_menu (id_menu);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index fk_am_id_user_group
--------------------------------------------------------
CREATE INDEX fk_am_id_user_group ON acm_menu (id_user_group);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index fk_am_id_menu_parent
--------------------------------------------------------
CREATE INDEX fk_am_id_menu_parent ON acm_menu (id_menu_parent);


<<|SEPARATOR|>>
--------------------------------------------------------
--  Constraints for Table acm_menu
--------------------------------------------------------
ALTER TABLE acm_menu ADD CONSTRAINT pk_acm_menu PRIMARY KEY (id_menu) ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  Ref Constraints for Table acm_menu
--------------------------------------------------------
ALTER TABLE acm_menu ADD CONSTRAINT fk_am_id_menu_parent FOREIGN KEY (id_menu_parent) REFERENCES acm_menu (id_menu) ENABLE;<<|SEPARATOR|>>
ALTER TABLE acm_menu ADD CONSTRAINT fk_am_id_user_group FOREIGN KEY (id_user_group) REFERENCES acm_user_group (id_user_group) ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  Sequence for AUTO_INCREMENT
--------------------------------------------------------
CREATE SEQUENCE sq_acm_menu MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 300 CACHE 20 NOORDER NOCYCLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Trigger for AUTO_INCREMENT
--------------------------------------------------------
CREATE OR REPLACE TRIGGER tgr_acm_menu BEFORE INSERT ON acm_menu
FOR EACH ROW
BEGIN
	IF :new.id_menu IS NULL OR :new.id_menu = 0 THEN
  		SELECT sq_acm_menu.NEXTVAL
    		INTO :new.id_menu
    	FROM DUAL;
    END IF;
END;


<<|SEPARATOR|>>
ALTER TRIGGER tgr_acm_menu ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Table acm_module
--------------------------------------------------------
CREATE TABLE acm_module 
(	
	id_module NUMBER(10,0) NOT NULL, 
	def_file VARCHAR2(2000 CHAR), 
	table_name VARCHAR2(50 CHAR), 
	controller VARCHAR2(50 CHAR) NOT NULL, 
	label VARCHAR2(250 CHAR) NOT NULL,  
	sql_list VARCHAR2(2000 CHAR), 
	url_img VARCHAR2(2000 CHAR), 
	description VARCHAR2(2000 CHAR), 
	dtt_inative DATE, 
	log_dtt_ins DATE DEFAULT SYSDATE
);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index pk_acm_module
--------------------------------------------------------
CREATE UNIQUE INDEX pk_acm_module ON acm_module (id_module);


<<|SEPARATOR|>>
--------------------------------------------------------
--  Constraints for Table acm_module
--------------------------------------------------------
ALTER TABLE acm_module ADD CONSTRAINT pk_acm_module PRIMARY KEY (id_module) ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  Sequence for AUTO_INCREMENT
--------------------------------------------------------
CREATE SEQUENCE sq_acm_module MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 300 CACHE 20 NOORDER NOCYCLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Trigger for AUTO_INCREMENT
--------------------------------------------------------
CREATE OR REPLACE TRIGGER tgr_acm_module BEFORE INSERT ON acm_module
FOR EACH ROW
BEGIN
	IF :new.id_module IS NULL OR :new.id_module = 0 THEN
  		SELECT sq_acm_module.NEXTVAL
    		INTO :new.id_module
    	FROM DUAL;
    END IF;
END;


<<|SEPARATOR|>>
ALTER TRIGGER tgr_acm_module ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Table acm_module_action
--------------------------------------------------------
CREATE TABLE acm_module_action 
(	
	id_module_action NUMBER(10,0) NOT NULL, 
	id_module NUMBER(10,0) NOT NULL, 
	label VARCHAR2(250 CHAR), 
	link VARCHAR2(2000 CHAR), 
	target VARCHAR2(50 CHAR),  
	url_img VARCHAR2(2000 CHAR), 
	order_ NUMBER(10,0), 
	dtt_inative DATE
);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index pk_acm_module_action
--------------------------------------------------------
CREATE UNIQUE INDEX pk_acm_module_action ON acm_module_action (id_module_action);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index fk_ama_id_module
--------------------------------------------------------
CREATE INDEX fk_ama_id_module ON acm_module_action (id_module);


<<|SEPARATOR|>>
--------------------------------------------------------
--  Constraints for Table acm_module_action
--------------------------------------------------------
ALTER TABLE acm_module_action ADD CONSTRAINT pk_acm_module_action PRIMARY KEY (id_module_action) ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  Ref Constraints for Table acm_module_action
--------------------------------------------------------
ALTER TABLE acm_module_action ADD CONSTRAINT fk_ama_id_module FOREIGN KEY (id_module) REFERENCES acm_module (id_module) ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  Sequence for AUTO_INCREMENT
--------------------------------------------------------
CREATE SEQUENCE sq_acm_module_action MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 300 CACHE 20 NOORDER NOCYCLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Trigger for AUTO_INCREMENT
--------------------------------------------------------
CREATE OR REPLACE TRIGGER tgr_acm_module_action BEFORE INSERT ON acm_module_action
FOR EACH ROW
BEGIN
	IF :new.id_module_action IS NULL OR :new.id_module_action = 0 THEN
  		SELECT sq_acm_module_action.NEXTVAL
    		INTO :new.id_module_action
    	FROM DUAL;
    END IF;
END;


<<|SEPARATOR|>>
ALTER TRIGGER tgr_acm_module_action ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Table acm_module_form
--------------------------------------------------------
CREATE TABLE acm_module_form 
(	
	id_module_form NUMBER(10,0) NOT NULL, 
	id_module NUMBER(10,0) NOT NULL, 
	operation VARCHAR2(45 CHAR), 
	action VARCHAR2(250 CHAR), 
	method VARCHAR2(20 CHAR), 
	enctype VARCHAR2(50 CHAR), 
	dtt_inative DATE
);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index fk_amf_id_module
--------------------------------------------------------
CREATE INDEX fk_amf_id_module ON acm_module_form (id_module);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index pk_acm_module_form
--------------------------------------------------------
CREATE UNIQUE INDEX pk_acm_module_form ON acm_module_form (id_module_form);


<<|SEPARATOR|>>
--------------------------------------------------------
--  Constraints for Table acm_module_form
--------------------------------------------------------
ALTER TABLE acm_module_form ADD CONSTRAINT pk_acm_module_form PRIMARY KEY (id_module_form) ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  Ref Constraints for Table acm_module_form
--------------------------------------------------------
ALTER TABLE acm_module_form ADD CONSTRAINT fk_amf_id_module FOREIGN KEY (id_module) REFERENCES acm_module (id_module) ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  Sequence for AUTO_INCREMENT
--------------------------------------------------------
CREATE SEQUENCE sq_acm_module_form MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 300 CACHE 20 NOORDER NOCYCLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Trigger for AUTO_INCREMENT
--------------------------------------------------------
CREATE OR REPLACE TRIGGER tgr_acm_module_form BEFORE INSERT ON acm_module_form
FOR EACH ROW
BEGIN
	IF :new.id_module_form IS NULL OR :new.id_module_form = 0 THEN
  		SELECT sq_acm_module_form.NEXTVAL
    		INTO :new.id_module_form
    	FROM DUAL;
    END IF;
END;


<<|SEPARATOR|>>
ALTER TRIGGER tgr_acm_module_form ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Table acm_module_form_field
--------------------------------------------------------
CREATE TABLE acm_module_form_field 
(	
	id_module_form_field NUMBER(10,0) NOT NULL, 
	id_module_form NUMBER(10,0) NOT NULL, 
	table_column VARCHAR2(50 CHAR), 
	type VARCHAR2(50 CHAR), 
	label VARCHAR2(100 CHAR), 
	description VARCHAR2(2000 CHAR), 
	id_html VARCHAR2(50 CHAR), 
	class_html VARCHAR2(50 CHAR), 
	maxlength NUMBER(10,0) DEFAULT '50', 
	options_rotules VARCHAR2(2000 CHAR), 
	options_values VARCHAR2(2000 CHAR), 
	options_sql VARCHAR2(2000 CHAR), 
	style VARCHAR2(2000 CHAR), 
	javascript VARCHAR2(2000 CHAR), 
	masks VARCHAR2(100 CHAR), 
	validations VARCHAR2(250 CHAR), 
	order_ NUMBER(10,0) DEFAULT '0', 
	dtt_inative DATE
);

<<|SEPARATOR|>>
COMMENT ON COLUMN acm_module_form_field.table_column IS 'Nome da coluna a qual o campo representa na tabela do modulo.';


<<|SEPARATOR|>>
COMMENT ON COLUMN acm_module_form_field.type IS 'input, textarea, file, checkbox, radio, select.';


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index fk_amff_id_module_form
--------------------------------------------------------
CREATE INDEX fk_amff_id_module_form ON acm_module_form_field (id_module_form);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index pk_acm_module_form_field
--------------------------------------------------------
CREATE UNIQUE INDEX pk_acm_module_form_field ON acm_module_form_field (id_module_form_field);


<<|SEPARATOR|>>
--------------------------------------------------------
--  Constraints for Table acm_module_form_field
--------------------------------------------------------
ALTER TABLE acm_module_form_field ADD CONSTRAINT pk_acm_module_form_field PRIMARY KEY (id_module_form_field) ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  Ref Constraints for Table acm_module_form_field
--------------------------------------------------------
ALTER TABLE acm_module_form_field ADD CONSTRAINT fk_amff_id_module_form FOREIGN KEY (id_module_form) REFERENCES acm_module_form (id_module_form) ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  Sequence for AUTO_INCREMENT
--------------------------------------------------------
CREATE SEQUENCE sq_acm_module_form_field MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 300 CACHE 20 NOORDER NOCYCLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Trigger for AUTO_INCREMENT
--------------------------------------------------------
CREATE OR REPLACE TRIGGER tgr_acm_module_form_field BEFORE INSERT ON acm_module_form_field
FOR EACH ROW
BEGIN
	IF :new.id_module_form_field IS NULL OR :new.id_module_form_field = 0 THEN
  		SELECT sq_acm_module_form_field.NEXTVAL
    		INTO :new.id_module_form_field
    	FROM DUAL;
    END IF;
END;


<<|SEPARATOR|>>
ALTER TRIGGER tgr_acm_module_form_field ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Table acm_module_menu
--------------------------------------------------------
CREATE TABLE acm_module_menu 
(	
	id_module_menu NUMBER(10,0) NOT NULL,  
	id_module NUMBER(10,0) NOT NULL, 
	label VARCHAR2(50 CHAR), 
	link VARCHAR2(2000 CHAR), 
	target VARCHAR2(50 CHAR),  
	url_img VARCHAR2(2000 CHAR), 
	order_ NUMBER(10,0), 
	dtt_inative DATE
);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index fk_amm_id_module
--------------------------------------------------------
CREATE INDEX fk_amm_id_module ON acm_module_menu (id_module);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index pk_acm_module_menu
--------------------------------------------------------
CREATE UNIQUE INDEX pk_acm_module_menu ON acm_module_menu (id_module_menu);


<<|SEPARATOR|>>
--------------------------------------------------------
--  Constraints for Table acm_module_menu
--------------------------------------------------------
ALTER TABLE acm_module_menu ADD CONSTRAINT pk_acm_module_menu PRIMARY KEY (id_module_menu) ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  Ref Constraints for Table acm_module_menu
--------------------------------------------------------
ALTER TABLE acm_module_menu ADD CONSTRAINT fk_amm_id_module FOREIGN KEY (id_module) REFERENCES acm_module (id_module) ENABLE;


<<|SEPARATOR|>>	
--------------------------------------------------------
--  Sequence for AUTO_INCREMENT
--------------------------------------------------------
CREATE SEQUENCE sq_acm_module_menu MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 300 CACHE 20 NOORDER NOCYCLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Trigger for AUTO_INCREMENT
--------------------------------------------------------
CREATE OR REPLACE TRIGGER tgr_acm_module_menu BEFORE INSERT ON acm_module_menu
FOR EACH ROW
BEGIN
	IF :new.id_module_menu IS NULL OR :new.id_module_menu = 0 THEN
  		SELECT sq_acm_module_menu.NEXTVAL
    		INTO :new.id_module_menu
    	FROM DUAL;
    END IF;
END;


<<|SEPARATOR|>>
ALTER TRIGGER tgr_acm_module_menu ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Table acm_module_permission
--------------------------------------------------------
CREATE TABLE acm_module_permission 
(	
	id_module_permission NUMBER(10,0) NOT NULL, 
	id_module NUMBER(10,0) NOT NULL, 
	label VARCHAR2(250 CHAR), 
	permission VARCHAR2(50 CHAR) NOT NULL, 
	description VARCHAR2(2000 CHAR), 
	dtt_inative DATE
);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index fk_amp_id_module
--------------------------------------------------------
CREATE INDEX fk_amp_id_module ON acm_module_permission (id_module);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index pk_acm_module_permission
--------------------------------------------------------
CREATE UNIQUE INDEX pk_acm_module_permission ON acm_module_permission (id_module_permission);


<<|SEPARATOR|>>
--------------------------------------------------------
--  Constraints for Table acm_module_permission
--------------------------------------------------------
ALTER TABLE acm_module_permission ADD CONSTRAINT pk_acm_module_permission PRIMARY KEY (id_module_permission) ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  Ref Constraints for Table acm_module_permission
--------------------------------------------------------
ALTER TABLE acm_module_permission ADD CONSTRAINT fk_amp_id_module FOREIGN KEY (id_module) REFERENCES acm_module (id_module) ENABLE;


<<|SEPARATOR|>>	
--------------------------------------------------------
--  Sequence for AUTO_INCREMENT
--------------------------------------------------------
CREATE SEQUENCE sq_acm_module_permission MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 300 CACHE 20 NOORDER NOCYCLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Trigger for AUTO_INCREMENT
--------------------------------------------------------
CREATE OR REPLACE TRIGGER tgr_acm_module_permission BEFORE INSERT ON acm_module_permission
FOR EACH ROW
BEGIN
	IF :new.id_module_permission IS NULL OR :new.id_module_permission = 0 THEN
  		SELECT sq_acm_module_permission.NEXTVAL
    		INTO :new.id_module_permission
    	FROM DUAL;
    END IF;
END;


<<|SEPARATOR|>>
ALTER TRIGGER tgr_acm_module_permission ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Table acm_user_config
--------------------------------------------------------
CREATE TABLE acm_user_config 
(	
	id_user_config NUMBER(10,0) NOT NULL, 
	id_user NUMBER(10,0) NOT NULL, 
	lang_default VARCHAR2(10 CHAR) DEFAULT 'pt_BR', 
	url_img VARCHAR2(2000 CHAR), 
	url_img_large VARCHAR2(2000 CHAR), 
	url_default VARCHAR2(2000 CHAR)
);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index pk_acm_user_config
--------------------------------------------------------
CREATE UNIQUE INDEX pk_acm_user_config ON acm_user_config (id_user_config);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index fk_auc_id_user
--------------------------------------------------------
CREATE INDEX fk_auc_id_user ON acm_user_config (id_user);


<<|SEPARATOR|>>
--------------------------------------------------------
--  Constraints for Table acm_user_config
--------------------------------------------------------
ALTER TABLE acm_user_config ADD CONSTRAINT pk_acm_user_config PRIMARY KEY (id_user_config) ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  Ref Constraints for Table acm_user_config
--------------------------------------------------------
ALTER TABLE acm_user_config ADD CONSTRAINT fk_auc_id_user FOREIGN KEY (id_user) REFERENCES acm_user (id_user) ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  Sequence for AUTO_INCREMENT
--------------------------------------------------------
CREATE SEQUENCE sq_acm_user_config MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 300 CACHE 20 NOORDER NOCYCLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Trigger for AUTO_INCREMENT
--------------------------------------------------------
CREATE OR REPLACE TRIGGER tgr_acm_user_config BEFORE INSERT ON acm_user_config
FOR EACH ROW
BEGIN
	IF :new.id_user_config IS NULL OR :new.id_user_config = 0 THEN
  		SELECT sq_acm_user_config.NEXTVAL
    		INTO :new.id_user_config
    	FROM DUAL;
    END IF;
END;


<<|SEPARATOR|>>
ALTER TRIGGER tgr_acm_user_config ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Table acm_user_permission
--------------------------------------------------------
CREATE TABLE acm_user_permission 
(	
	id_user_permission NUMBER(10,0) NOT NULL, 
	id_user NUMBER(10,0) NOT NULL, 
	id_module_permission NUMBER(10,0) NOT NULL
);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index pk_acm_user_permission
--------------------------------------------------------
CREATE UNIQUE INDEX pk_acm_user_permission ON acm_user_permission (id_user_permission);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for fk_aup_id_user
--------------------------------------------------------
CREATE INDEX fk_aup_id_user ON acm_user_permission (id_user);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index fk_aup_id_module_permission
--------------------------------------------------------
CREATE INDEX fk_aup_id_module_permission ON acm_user_permission (id_module_permission);


<<|SEPARATOR|>>
--------------------------------------------------------
--  Constraints for Table acm_user_permission
--------------------------------------------------------
ALTER TABLE acm_user_permission ADD CONSTRAINT pk_acm_user_permission PRIMARY KEY (id_user_permission) ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  Ref Constraints for Table acm_user_permission
--------------------------------------------------------
ALTER TABLE acm_user_permission ADD CONSTRAINT fk_aup_id_module_permission FOREIGN KEY (id_module_permission) REFERENCES acm_module_permission (id_module_permission) ENABLE;<<|SEPARATOR|>>
ALTER TABLE acm_user_permission ADD CONSTRAINT fk_aup_id_user FOREIGN KEY (id_user) REFERENCES acm_user (id_user) ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  Sequence for AUTO_INCREMENT
--------------------------------------------------------
CREATE SEQUENCE sq_acm_user_permission MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 300 CACHE 20 NOORDER NOCYCLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Trigger for AUTO_INCREMENT
--------------------------------------------------------
CREATE OR REPLACE TRIGGER tgr_acm_user_permission BEFORE INSERT ON acm_user_permission
FOR EACH ROW
BEGIN
	IF :new.id_user_permission IS NULL OR :new.id_user_permission = 0 THEN
  		SELECT sq_acm_user_permission.NEXTVAL
    		INTO :new.id_user_permission
    	FROM DUAL;
    END IF;
END;


<<|SEPARATOR|>>
ALTER TRIGGER tgr_acm_user_permission ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Table acm_user_reset_password
--------------------------------------------------------
CREATE TABLE acm_user_reset_password 
(	
	id_user_reset_password NUMBER(10,0) NOT NULL, 
	id_user NUMBER(10,0) NOT NULL, 
	email VARCHAR2(250 CHAR), 
	key_access VARCHAR2(2000 CHAR) NOT NULL, 
	dtt_updated DATE, 
	log_dtt_ins DATE DEFAULT SYSDATE
);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index pk_acm_user_reset_password
--------------------------------------------------------
CREATE UNIQUE INDEX pk_acm_user_reset_password ON acm_user_reset_password (id_user_reset_password);


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Index fk_aurp_id_user
--------------------------------------------------------
CREATE INDEX fk_aurp_id_user ON acm_user_reset_password (id_user);


<<|SEPARATOR|>>
--------------------------------------------------------
--  Constraints for Table acm_user_reset_password
--------------------------------------------------------
ALTER TABLE acm_user_reset_password ADD CONSTRAINT pk_acm_user_reset_password PRIMARY KEY (id_user_reset_password) ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  Ref Constraints for Table acm_user_reset_password
--------------------------------------------------------
ALTER TABLE acm_user_reset_password ADD CONSTRAINT fk_aurp_id_user FOREIGN KEY (id_user) REFERENCES acm_user (id_user) ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  Sequence for AUTO_INCREMENT
--------------------------------------------------------
CREATE SEQUENCE sq_acm_user_reset_password MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 300 CACHE 20 NOORDER NOCYCLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  DDL for Trigger for AUTO_INCREMENT
--------------------------------------------------------
CREATE OR REPLACE TRIGGER tgr_acm_user_reset_password BEFORE INSERT ON acm_user_reset_password
FOR EACH ROW
BEGIN
	IF :new.id_user_reset_password IS NULL OR :new.id_user_reset_password = 0 THEN
  		SELECT sq_acm_user_reset_password.NEXTVAL
    		INTO :new.id_user_reset_password
    	FROM DUAL;
    END IF;
END;


<<|SEPARATOR|>>
ALTER TRIGGER tgr_acm_user_reset_password ENABLE;


<<|SEPARATOR|>>
--------------------------------------------------------
--  INSERTS for Table acm_user_group
--------------------------------------------------------
INSERT INTO acm_user_group VALUES (1,'ROOT','Usuários com super privilégios na aplicação.',NULL);


<<|SEPARATOR|>>
--------------------------------------------------------
--  INSERTS for Table acm_user
--------------------------------------------------------
INSERT INTO acm_user VALUES (1,1,'acmeengine','7c58c7b6630b6c2377b41a0c56cea568','ACME Engine','leandro.w3c@gmail.com',NULL,NULL,SYSDATE);


<<|SEPARATOR|>>
--------------------------------------------------------
--  INSERTS for Table acm_user_config
--------------------------------------------------------
INSERT INTO acm_user_config VALUES (1,1,'pt_BR',NULL,NULL,'<app eval="URL_ROOT"/>/app_dashboard');


<<|SEPARATOR|>>
--------------------------------------------------------
--  INSERTS for Table acm_menu
--------------------------------------------------------
INSERT INTO acm_menu VALUES (12,NULL,1,'Dashboard','<app eval="URL_ROOT"/>/app_dashboard',NULL,'<i class="fa fa-dashboard fa-fw"></i>',10,NULL);<<|SEPARATOR|>>
INSERT INTO acm_menu VALUES (25,NULL,1,'Configurações e sessão','<app eval="URL_ROOT" />/app_config/',NULL,'<i class="fa fa-cogs fa-fw"></i>',20,NULL);<<|SEPARATOR|>>
INSERT INTO acm_menu VALUES (10,NULL,1,'Menus','<app eval="URL_ROOT" />/app_menu/',NULL,'<i class="fa fa-tasks fa-fw"></i>',30,NULL);<<|SEPARATOR|>>
INSERT INTO acm_menu VALUES (11,NULL,1,'Logs','<app eval="URL_ROOT" />/app_log/',NULL,'<i class="fa fa-tags fa-fw"></i>',40,NULL);<<|SEPARATOR|>>
INSERT INTO acm_menu VALUES (13,NULL,1,'Usuários','<app eval="URL_ROOT" />/app_user/',NULL,'<i class="fa fa-users fa-fw"></i>',50,NULL);<<|SEPARATOR|>>
INSERT INTO acm_menu VALUES (20,NULL,1,'Módulos',NULL,NULL,'<i class="fa fa-archive fa-fw"></i>',60,NULL);<<|SEPARATOR|>>
INSERT INTO acm_menu VALUES (21,20,1,'Administração','<app eval="URL_ROOT" />/app_module_manager/',NULL,'<i class="fa fa-wrench fa-fw"></i>',70,NULL);<<|SEPARATOR|>>
INSERT INTO acm_menu VALUES (22,20,1,'Construtor','<app eval="URL_ROOT" />/app_module_maker/',NULL,'<i class="fa fa-flask fa-fw"></i>',80,NULL);


<<|SEPARATOR|>>
--------------------------------------------------------
--  INSERTS for Table acm_module
--------------------------------------------------------
INSERT INTO acm_module VALUES (1,NULL,'acm_module','app_module_manager','Administração de módulos',NULL,'<i class="fa fa-wrench fa-fw"></i>',NULL,NULL,SYSDATE);<<|SEPARATOR|>>
INSERT INTO acm_module VALUES (2,NULL,NULL,'app_maker','Construtor de módulos',NULL,'<i class="fa fa-flask fa-fw"></i>',NULL,NULL,SYSDATE);<<|SEPARATOR|>>
INSERT INTO acm_module VALUES (3,NULL,'acm_user','app_user','Usuários',NULL,'<i class="fa fa-users fa-fw"></i>',NULL,NULL,SYSDATE);<<|SEPARATOR|>>
INSERT INTO acm_module VALUES (5,NULL,NULL,'app_dashboard','Dashboard',NULL,'<i class="fa fa-dashboard fa-fw"></i>',NULL,NULL,SYSDATE);<<|SEPARATOR|>>
INSERT INTO acm_module VALUES (6,NULL,'acm_log','app_log','Logs da aplicação',NULL,'<i class="fa fa-tags fa-fw"></i>',NULL,NULL,SYSDATE);<<|SEPARATOR|>>
INSERT INTO acm_module VALUES (7,NULL,'acm_menu','app_menu','Menus da aplicação',NULL,'<i class="fa fa-tasks fa-fw"></i>',NULL,NULL,SYSDATE);<<|SEPARATOR|>>
INSERT INTO acm_module VALUES (15,NULL,NULL,'app_config','Configurações e sessão',NULL,'<i class="fa fa-cogs fa-fw"></i>',NULL,NULL,SYSDATE);


<<|SEPARATOR|>>
--------------------------------------------------------
--  INSERTS for Table acm_module_permission
--------------------------------------------------------
INSERT INTO acm_module_permission VALUES (1,1,'Entrar no módulo','ENTER',NULL,NULL);<<|SEPARATOR|>>
INSERT INTO acm_module_permission VALUES (2,1,'Configurar formulários','CONFIG_FORMS',NULL,NULL);<<|SEPARATOR|>>
INSERT INTO acm_module_permission VALUES (10,1,'Administrar módulo','ADMINISTRATION',NULL,NULL);<<|SEPARATOR|>>
INSERT INTO acm_module_permission VALUES (21,1,'Alterar dados de módulos internos (ACME)','MANAGE_ACME_MODULES','Esta permissão é testada toda vez que o usuário tentar alterar alguma propriedade ou inserir alguma permissão, ação ou menu para um módulo interno, ou seja, do próprio ACME.',NULL);<<|SEPARATOR|>>
INSERT INTO acm_module_permission VALUES (3,2,'Entrar no módulo','ENTER',NULL,NULL);<<|SEPARATOR|>>
INSERT INTO acm_module_permission VALUES (4,2,'Criar novo módulo','CREATE_MODULE',NULL,NULL);<<|SEPARATOR|>>
INSERT INTO acm_module_permission VALUES (5,3,'Entrar no módulo','ENTER',NULL,NULL);<<|SEPARATOR|>>
INSERT INTO acm_module_permission VALUES (28,3,'Gerenciar permissões','PERMISSION_MANAGER','Esta permissão é testada quando há a tentativa de acesso à tela de edição de permissões de um determinado usuário.',NULL);<<|SEPARATOR|>>
INSERT INTO acm_module_permission VALUES (61,3,'Inserir','INSERT',NULL,NULL);<<|SEPARATOR|>>
INSERT INTO acm_module_permission VALUES (62,3,'Editar','UPDATE',NULL,NULL);<<|SEPARATOR|>>
INSERT INTO acm_module_permission VALUES (63,3,'Editar perfil','EDIT_PROFILE',NULL,NULL);<<|SEPARATOR|>>
INSERT INTO acm_module_permission VALUES (64,3,'Solicitar reset de senha','RESET_PASSWORD','Esta permissão é testada quando há tentativa de acesso à funcionalidade de solicitação de alteração de senha (enviada por email).',NULL);<<|SEPARATOR|>>
INSERT INTO acm_module_permission VALUES (66,3,'Copiar permissões','COPY_PERMISSIONS',NULL,NULL);<<|SEPARATOR|>>
INSERT INTO acm_module_permission VALUES (7,5,'Visualizar dashboard','VIEW_DASHBOARD',NULL,NULL);<<|SEPARATOR|>>
INSERT INTO acm_module_permission VALUES (8,6,'Entrar no módulo','ENTER',NULL,NULL);<<|SEPARATOR|>>
INSERT INTO acm_module_permission VALUES (15,6,'Visualizar','VIEW',NULL,NULL);<<|SEPARATOR|>>
INSERT INTO acm_module_permission VALUES (67,6,'Deletar','DELETE',NULL,NULL);<<|SEPARATOR|>>
INSERT INTO acm_module_permission VALUES (9,7,'Entrar no módulo','ENTER',NULL,NULL);<<|SEPARATOR|>>
INSERT INTO acm_module_permission VALUES (52,7,'Editar','UPDATE',NULL,NULL);<<|SEPARATOR|>>
INSERT INTO acm_module_permission VALUES (53,7,'Deletar','DELETE',NULL,NULL);<<|SEPARATOR|>>
INSERT INTO acm_module_permission VALUES (54,7,'Inserir','INSERT',NULL,NULL);<<|SEPARATOR|>>
INSERT INTO acm_module_permission VALUES (56,15,'Entrar no módulo','ENTER',NULL,NULL);


<<|SEPARATOR|>>
--------------------------------------------------------
--  INSERTS for Table acm_user_permission
--------------------------------------------------------
INSERT INTO acm_user_permission VALUES (1,1,1);<<|SEPARATOR|>>
INSERT INTO acm_user_permission VALUES (2,1,2);<<|SEPARATOR|>>
INSERT INTO acm_user_permission VALUES (3,1,3);<<|SEPARATOR|>>
INSERT INTO acm_user_permission VALUES (4,1,4);<<|SEPARATOR|>>
INSERT INTO acm_user_permission VALUES (5,1,5);<<|SEPARATOR|>>
INSERT INTO acm_user_permission VALUES (7,1,7);<<|SEPARATOR|>>
INSERT INTO acm_user_permission VALUES (8,1,8);<<|SEPARATOR|>>
INSERT INTO acm_user_permission VALUES (9,1,9);<<|SEPARATOR|>>
INSERT INTO acm_user_permission VALUES (10,1,10);<<|SEPARATOR|>>
INSERT INTO acm_user_permission VALUES (11,1,15);<<|SEPARATOR|>>
INSERT INTO acm_user_permission VALUES (17,1,28);<<|SEPARATOR|>>
INSERT INTO acm_user_permission VALUES (18,1,21);<<|SEPARATOR|>>
INSERT INTO acm_user_permission VALUES (36,1,53);<<|SEPARATOR|>>
INSERT INTO acm_user_permission VALUES (37,1,52);<<|SEPARATOR|>>
INSERT INTO acm_user_permission VALUES (38,1,54);<<|SEPARATOR|>>
INSERT INTO acm_user_permission VALUES (46,1,61);<<|SEPARATOR|>>
INSERT INTO acm_user_permission VALUES (47,1,62);<<|SEPARATOR|>>
INSERT INTO acm_user_permission VALUES (52,1,63);<<|SEPARATOR|>>
INSERT INTO acm_user_permission VALUES (53,1,64);<<|SEPARATOR|>>
INSERT INTO acm_user_permission VALUES (54,1,66);<<|SEPARATOR|>>
INSERT INTO acm_user_permission VALUES (95,1,67);<<|SEPARATOR|>>
INSERT INTO acm_user_permission VALUES (106,1,56);
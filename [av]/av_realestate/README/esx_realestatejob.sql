INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_realestate', 'Real Estate', 0)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_realestate', 'Real Estate', 0)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_realestate', 'Real Estate', 0)
;

INSERT INTO `jobs` (name, label) VALUES
	('realestate', 'Real Estate')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('realestate',0,'employee','Employee',20,'{}','{}'),
	('realestate',1,'boss','Boss',40,'{}','{}'),
;
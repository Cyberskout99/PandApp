--Populate the roles_db table
INSERT INTO Roles_db (Role, Description) 
VALUES 
('ReadOnly', 'Can read, but not write to the db'),
('ReadWrite', 'Can read and write to the db')
;

--Populate the roles_app table
INSERT INTO Roles_app (Role, Description)
VALUES
('Researcher', 'All access'),
('Intern', 'records labs and behaviors'),
('Keeper','records birth / infant / rear observations'),
('Lab', 'records labs'),
('External Researcher', 'Read Only')
;

--Populate the Staff Table with placeholder data for testing only
INSERT INTO Staff_tbl (StaffFirst, StaffLast, Username, Password) 
VALUES 
('Much','Access','CanWrite', '1234'),
('Less','Access','CanRead', '1234')
;

--Populate the DB Role Assignments Table with placeholder data for testing only
INSERT INTO RoleApp_Assignments (StaffID_fk, RoleAppId) 
VALUES 
(1,1),
(2,2)
;

--Populate the DB Role Assignments Table with placeholder data for testing only
INSERT INTO RoleApp_Assignments (StaffID_fk, RoleAppId) 
VALUES 
(1,1),
(2,4)
;

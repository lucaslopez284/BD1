/* Crea un usuario para las bases de datos usando el nombre ‘appt_user’.
Asigne a estos todos los permisos sobre sus respectivas tablas. */
CREATE USER 'appt_user'@'localhost' IDENTIFIED BY 'Appt_user_123';
GRANT ALL ON appointments.* TO 'appt_user'@'localhost';

/* a. Cree un usuario sólo con permisos para realizar consultas de selección, 
es decir que no puedan realizar cambios en la base (ni estructural ni de datos).
Use el nombre ‘appt_select’. */ 
CREATE USER 'appt_select'@'localhost' IDENTIFIED BY 'Appt_select_123';
GRANT SELECT ON appointments.* TO 'appt_select'@'localhost';

/* b. Cree un usuario que pueda realizar consultas de selección, inserción,
actualización y eliminación a nivel de filas, pero que no puedan modificar el
esquema. Use el nombre ‘appt_update’. */
CREATE USER 'appt_update'@'localhost' IDENTIFIED BY 'Appt_update_123';
GRANT SELECT, INSERT, UPDATE, DELETE ON appointments.* TO 'appt_update'@'localhost';

/* c. Cree un usuario que tenga los permisos de los anteriores, 
pero que además pueda modificar el esq */
CREATE USER 'appt_schema'@'localhost' IDENTIFIED BY 'Appt_schema_123';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, DROP
ON appointments.* TO 'appt_schema'@'localhost';

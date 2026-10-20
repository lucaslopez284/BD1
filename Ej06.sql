/* 6. Crear un Stored Procedure que realice los siguientes 
pasos dentro de una transacción:
a. Realizar la siguiente consulta: cada pacient 
(identificado por patient_id), calcule la cantidad de appointments 
que tiene registradas. Registrar la fecha en la que se realiza esta 
carga y además del usuario con el se realiza.
b. Guardar el resultado de la consulta en un cursor.
c. Iterar el cursor e insertar los valores correspondientes en la tabla
APPOINTMENTS_PER_PATIENT. Tenga en cuenta que last_update es la fecha 
en que se realiza esta carga, es decir la fecha actual, mientras que
user es el usuario logueado actualmente, utilizar las correspondientes
funciones para esto. Para el campo user, guardar únicamente 
el nombre de usuario, sin el host. */

/* Guardado del procedimiento */
DELIMITER //
CREATE PROCEDURE ejercicio_6()
BEGIN
	DECLARE id_paciente INTEGER;
    DECLARE cantidad INTEGER;
    DECLARE usuario varchar(50);
    DECLARE fin INTEGER DEFAULT 0;
	DECLARE cursor_ej6 CURSOR FOR
		SELECT a.patient_id, COUNT(*) AS count_appointments
		FROM appointment a
		GROUP BY a.patient_id;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
		ROLLBACK;
    SET usuario = substring_index(user(), '@', 1);
    START TRANSACTION;
    OPEN cursor_ej6;
	loop_cursor: LOOP
		FETCH NEXT FROM cursor_ej6 into id_paciente, cantidad;
        IF fin = 1 THEN
			LEAVE loop_cursor;
		END IF;
        INSERT INTO appointments.appointments_per_patient (patient_id, count_appointments, last_update,  `user`)
        VALUES (id_paciente, cantidad, now(), usuario);
	END LOOP;
    CLOSE cursor_ej6;
	COMMIT;
END //
DELIMITER ;

/* LLamado al procedimiento*/ 
CALL ejercicio_6();
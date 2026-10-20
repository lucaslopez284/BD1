/* Crear un Trigger de modo que al insertar un dato en la tabla Appointment, se
actualice la cantidad de appointments del paciente, la fecha de actualización y el
usuario responsable de la misma (actualiza la tabla
APPOINTMENTS_PER_PATIENT).
Para el campo user, guardar únicamente el nombre de usuario, sin el host. */

DELIMITER //
CREATE TRIGGER ejercicio_8
AFTER INSERT ON appointments.appointment
FOR EACH ROW
BEGIN
	DECLARE usuario varchar(50);
	SET usuario = current_user();
	IF NEW.patient_id IN (SELECT ap.patient_id FROM appointments_per_patient ap) THEN
		UPDATE appointments_per_patient ap
        SET count_appointments= count_appointments + 1, last_update = now(), `user` = usuario
        WHERE NEW.patient_id = ap.patient_id;
	ELSE
		INSERT INTO appointments_per_patient (patient_id, count_appointments, last_update,  `user`)
        VALUES (NEW.patient_id, 1, now(), usuario);
	END IF;
END//
DELIMITER ;
DELIMITER //
CREATE TRIGGER ejercicio_8
AFTER INSERT ON appointments.appointment
FOR EACH ROW
BEGIN
	DECLARE usuario varchar(50);
	SET usuario = substring_index(user(), '@', 1);
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
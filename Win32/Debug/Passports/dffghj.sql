DELIMITER $$

USE `student_system`$$

DROP VIEW IF EXISTS `passports_view`$$

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `passports_view` AS (
SELECT
  `a`.`admission_number` AS `admission_number`,
  CONCAT(`a`.`surname`,' ',`a`.`firstname`,' ',`a`.`lastname`) AS `full_name`,
  `a`.`current_class`    AS `current_class`,
  `a`.`current_stream`   AS `current_stream`,
  `a`.`photo` AS `photo`,
  CONCAT(`p`.`path`,`a`.`admission_number`,'.jpg') AS `path`
FROM (`admissions_table` `a`
   JOIN `passports_folder_path_table` `p`))$$

DELIMITER ;
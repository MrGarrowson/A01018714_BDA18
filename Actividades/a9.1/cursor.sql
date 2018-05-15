-- Utiliza la base de datos Sakila
-- Crea un stored procedure que incluya un cursor para modificar el title de la tabla films de forma que cada título ahora tenga com prefijo el name correspondiente a la categoría de la película (tabla categoría). Ejemplo: la película "The thing" ahora se llamarra "Horror_The thing"
DELIMITER // 
CREATE PROCEDURE curdemo()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE genre varCHAR(20);
  DECLARE tid,cid tinyint;
  DECLARE cur1 CURSOR FOR SELECT film_id FROM film;
  DECLARE cur2 CURSOR FOR SELECT category_id FROM film_category where category_id=tid;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur1;

  read_loop: LOOP
    
    IF done THEN
      LEAVE read_loop;
    END IF;

        FETCH cur1 INTO tid;
        FETCH cur2 INTO cid;

        UPDATE film SET title = CONCAT((Select name from category where category_id=cid),"_",(SELECT tile from films WHERE id = tid));
        
    END LOOP;

  CLOSE cur1;

END;
//

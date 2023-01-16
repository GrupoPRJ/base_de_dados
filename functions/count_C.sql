CREATE DEFINER=`root`@`localhost` FUNCTION `count_C`(seq MEDIUMTEXT) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE res INT;
		SET res = (length(seq) - length(replace(seq, 'C', '')));
	RETURN(res);
END
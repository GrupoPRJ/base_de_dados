CREATE DEFINER=`root`@`localhost` FUNCTION `count_U`(seq MEDIUMTEXT) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE res INT;
		SET res = (length(seq) - length(replace(seq, 'U', '')));
	RETURN(res);
END
CREATE DEFINER=`root`@`localhost` FUNCTION `count_T`(seq MEDIUMTEXT) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE res INT;
		SET res = (length(seq) - length(replace(seq, 'T', '')));
	RETURN(res);
END
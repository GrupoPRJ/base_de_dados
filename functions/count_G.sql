CREATE DEFINER=`root`@`localhost` FUNCTION `count_G`(seq MEDIUMTEXT) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE res INT;
		SET res = (length(seq) - length(replace(seq, 'G', '')));
	RETURN(res);
END
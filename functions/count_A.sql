CREATE DEFINER=`root`@`localhost` FUNCTION `count_A`(seq MEDIUMTEXT) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE res INT;
		SET res = (length(seq) - length(replace(seq, 'A', '')));
	RETURN(res) ;
END
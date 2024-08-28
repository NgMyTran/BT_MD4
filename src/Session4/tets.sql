# các hàm trong mySQL (freetuts)
SELECT * FROM world.city;
-- tổng dân số world
select sum(population) from `world`.`country`city;

-- tổng dân số của mỗi nc dc htoongs kê trong bảng tp
SELECT * FROM world.country;
select country.code, sum(city.population), country.Popuation
from city
         JOIN country ON city.CountryCode = country.code
where countrycode is not NULL
group by country.code;

-- lấy những tp có dân số>100000 ng của nga
select * from city where CountryCode LIKE 'RUS';
select * from (select * from city where CountryCode LIKE 'RUS') as view_city_rus_population
where view_city_rus_population > 100000;

-- lấy những nc có tổng số thành phố nhiều nhất
-- tính số lượng tp lớn nhất
select count(id) from city
group by countrycode
order by count(id) limit 1;
;
-- lấy ra nhưncg nc có số lg tp=363
SELECT * FROM world.city;
select countryCode, count(id) from city
group by countrycode
having count(id) = (select count(id) from city
                    group by countrycode
                    order by count(id) limit 1);

# so sánh ALL
SELECT * FROM world.city;
select countryCode, count(id)  `tong` from city
group by countrycode;
select countrycode tong from (select countryCode, count(id)  `tong` from city
                              group by countrycode) ct where tong >= ALL(select countrycode tong from (select countryCode, count(id)  `tong` from city
                                                                                                       group by countrycode) c);

#UNION
select * from city
union
select code, naem, population, localname, capital from country;

-- các cú pháp
select * from ketqua


arr = javaArray('java.math.BigDecimal', 4)
arr(1) = java.math.BigDecimal(5);
arr(2) = java.math.BigDecimal(54);
arr(3) = java.math.BigDecimal(544);
arr(4) = java.math.BigDecimal(523232);
arr
tmp = arr(4)

x = java.math.BigDecimal(1e-10);
y = java.math.BigDecimal(1e-10);

z = x.multiply(y)
z = z.multiply(z)

zd = double(z)

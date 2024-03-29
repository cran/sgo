### sgo_etrs_laea Input ###
# wrong epsg
expect_error(sgo_etrs_laea(sgo_points(list(-3.161557, 55.94410), epsg=4326)),
             "only supports ETRS89 coordinates")
# additional elements
ln <- c(-4.22472, -2.09908)
lt <- c(57.47777, 57.14965)
N <- c("Inverness", "Aberdeen")
country <- c("Scotland", "Scotland")
df <- data.frame(N, ln, lt, country, stringsAsFactors = FALSE)
p1 <- sgo_etrs_laea(sgo_points(df, coords=c("ln", "lt"), epsg=4258))
e <- c(3473154.62807, 3591926.88100)
n <- c(3904229.53701, 3844820.05254)
df2 <- data.frame(N, country, e, n, stringsAsFactors = FALSE)
p2 <- sgo_points(df2, coords=c("e", "n"), epsg=3035)
expect_true(all(abs(as.data.frame(p1[1:2]) -
                      as.data.frame(p2[1:2])) < 0.00001))
expect_equal(as.data.frame(p1[3:4]), as.data.frame(p2[3:4]))


### sgo_laea_etrs Input ###
# wrong epsg
expect_error(sgo_laea_etrs(sgo_points(list(3503432.10, 3724031.05),
                                      epsg=3857)),
             "only supports coordinates in EPSG:3035")
# additional elements
e <- c(3473154.62807, 3591926.88100)
n <- c(3904229.53701, 3844820.05254)
N <- c("Inverness", "Aberdeen")
country <- c("Scotland", "Scotland")
df <- data.frame(N, e, n, country, stringsAsFactors = FALSE)
p1 <- sgo_laea_etrs(sgo_points(df, coords=c("e", "n"), epsg=3035))
ln <- c(-4.22472, -2.09908)
lt <- c(57.47777, 57.14965)
df2 <- data.frame(N, country, ln, lt, stringsAsFactors = FALSE)
p2 <- sgo_points(df2, coords=c("ln", "lt"), epsg=4258)
expect_true(all(abs(as.data.frame(p1[1:2]) -
                      as.data.frame(p2[1:2])) < 0.000001))
expect_equal(as.data.frame(p1[3:4]), as.data.frame(p2[3:4]))

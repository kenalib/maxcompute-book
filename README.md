

# MaxCompute Book

Updated sample code in the book ODPS权威指南 by 李妹芳

* https://www.amazon.cn/dp/B00QIIBG24
* https://github.com/duckrun/odps_book

I tried to minimize the code changes so that readers can follow the book easily.


![ODPS Book Image](ODPS_book.jpg)


## Initial setup

### create a project

* refer https://www.alibabacloud.com/help/doc-detail/27815.htm

### setup ODPS console

* refer https://www.alibabacloud.com/help/doc-detail/27804.htm
* download the latest zip from http://repo.aliyun.com/odpscmd/
* extract as follows (sample commands on Mac)

```bash
mkdir ~/odpscmd     # make sure you create folder before unzip
unzip -d ~/odpscmd/ ~/Downloads/odpscmd_public.zip
```

* try `~/odpscmd/bin/odpscmd --version` to confirm it is working
* update `~/odpscmd/conf/odps_config.ini`

```
project_name=ODPSBook
access_id=xxxxxxxxxxxxxxxx
access_key=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
end_point=http://service.ap-southeast-1.maxcompute.aliyun.com/api
# c.f. end point list: https://www.alibabacloud.com/help/doc-detail/34951.htm
```

* try `~/odpscmd/bin/odpscmd` and `whoami;` to confirm it is working

```
~/odpscmd $ ~/odpscmd/bin/odpscmd -e "whoami;"
Name: ALIYUN$0000000000000000
End_Point: http://service.ap-southeast-1.maxcompute.aliyun.com/api
Project: ODPSBook
```

* add `export PATH=$PATH:~/odpscmd/bin` in ~/.bash_profile
* restart terminal to make sure it has been added to `PATH`

### setup IntelliJ IDEA and MaxCompute Studio

* install https://www.jetbrains.com/idea/download/
* install https://plugins.jetbrains.com/plugin/9193-maxcompute-studio

### setup account in MaxCompute Studio

* start IntelliJ IDEA
* choose `VCS | Checkout from Version Control | Git` to clone this repository
* choose left side `Project Explorer | plus icon`
* select the above `odps_config.ini` in the Properties File

### setup UDF

* choose right side `Maven Projects`, double click `clean` and `package`
* click to select `Project | target/MaxComputeBook-1.0-SNAPSHOT.jar`
* choose `MaxCompute | Add Resource | OK`
* choose `MaxCompute | Create Function`
* fill out as function name: `myip2region`, Main class: `myudf.MyIP2Region`
* try query as `odpscmd -e "SELECT myip2region('101.105.35.57', 'COUNTRY');"`

### setup R and RStudio

* install https://www.r-project.org/
* install https://www.rstudio.com/products/rstudio/download/


## Chapter 2

please check [Chapter 2 README](./book/ch2_intro)


## Chapter 3

please check [Chapter 3 README](./book/ch3_tunnel)


## Sample UDF

* the source is `src/main/java/myudf/MyIP2Region.java`
* it is based on https://github.com/lionsoul2014/ip2region
* choose `Run | Run | MyIP2Region` for test run locally


## Reference

* ODPS权威指南 https://www.amazon.cn/dp/B00QIIBG24
* Meifang's Repo https://github.com/duckrun/odps_book
* IP2Region Code https://github.com/lionsoul2014/ip2region
* Official Doc EN https://www.alibabacloud.com/help/product/27797.htm
* Prepare Account https://www.alibabacloud.com/help/doc-detail/27803.htm
* MaxCompute Studio https://www.alibabacloud.com/help/doc-detail/50889.htm

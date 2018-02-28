

# MaxCompute Book

Updated sample code in ODPS权威指南

![ODPS Book Image](ODPS_book.jpg)


## Initial setup

### setup ODPS console

* refer https://www.alibabacloud.com/help/doc-detail/27804.htm
* extract `odpscmd_public.zip` as `~/bin/odpscmd_public/bin/odpscmd`
* update `~/bin/odpscmd_public/conf/odps_config.ini`

```
project_name=ODPSBook
access_id=xxxxxxxxxxxxxxxx
access_key=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
end_point=http://service.ap-southeast-1.maxcompute.aliyun.com/api
# c.f. end point list: https://www.alibabacloud.com/help/doc-detail/34951.htm
```

### setup IntelliJ IDEA and MaxCompute Studio

* install https://www.jetbrains.com/idea/download/
* install https://plugins.jetbrains.com/plugin/9193-maxcompute-studio

### setup R and RStudio

* install https://www.r-project.org/
* install https://www.rstudio.com/products/rstudio/download/


## Chapter 2

### prepare log data

* extract `resources/coolshell_20140212.log.tar.gz` as `data/coolshell_20140212.log`
* `prepare_data.sh` to generate data/coolshell_${DATE}.log
* `parse_run.sh` to create data/${DATE}/output.log

### prepare table data

* `create_table_all.sh` to create all tables
* `data_upload.sh` to upload log data

### download result data

* `load.sh` to populate result table data
* `data_download.sh` to download ADM (Application Data Mart) tables
* open R scripts from RStudio and push "Source" to draw charts


## Reference

* ODPS权威指南 https://www.amazon.cn/dp/B00QIIBG24
* Meifang's Repo https://github.com/duckrun/odps_book
* Official Doc CN https://help.aliyun.com/product/27797.html
* Official Doc EN https://www.alibabacloud.com/help/product/27797.htm
* MaxCompute Studio https://help.aliyun.com/document_detail/50889.html

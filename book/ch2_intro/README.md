
## Chapter 2

Chapter 2 explains web access log analysis.

### prepare log data

* extract original log file, generate 1 week logs and parse those logs

```bash
cd book/ch2_intro
# extract archived log file as data/coolshell_20140212.log
tar -xvf resources/coolshell_20140212.log.tar.gz -C ./data/
# generate 7 log files as data/coolshell_${DATE}.log
./script/prepare_data.sh
# parse each logs and create data/${DATE}/output.log
./script/parse_run.sh
```

### prepare table data

* create tables on MaxCompute side and upload log data

```bash
# create all tables on MaxCompute
./script/create_table_all.sh
# upload log data to MaxCompute
./script/data_upload.sh
```

### download result data

* run Hive queries and download the result

```bash
# populate result table data (note: takes about 1 hour)
./script/load.sh
# download ADM (Application Data Mart) tables
./script/data_download.sh
```

* open R scripts from RStudio and push "Source" button to draw charts

```
open script/referer_pie.r
open script/measures_weekly_line.r
```

You should see exact same charts on the book.

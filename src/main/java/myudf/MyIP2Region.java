package myudf;

import com.aliyun.odps.udf.UDF;
import org.apache.commons.io.IOUtils;
import org.lionsoul.ip2region.*;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

/**
 * Returns the region of the given ip address.
 * You can specify the level as ‘COUNTRY’, ‘AREA’, ‘PROVINCE’, ‘CITY’, ‘ISP’.
 *
 * 支持的语法：
 * ip2region(ip_address, level)
 *
 * 例子：
 * SELECT ip2region('101.105.35.57', 'COUNTRY');
 * SELECT ip2region('101.105.35.57', 'Province');
 * SELECT ip2region('101.105.35.57', 'CITY');
 *
 * https://github.com/lionsoul2014/ip2region
 */

public class MyIP2Region extends UDF {
    private static byte[] dbBinStr;

    public MyIP2Region() {
        ClassLoader classLoader = getClass().getClassLoader();
        String db_file_name = "ip2region.db";
        InputStream is = classLoader.getResourceAsStream(db_file_name);

        try {
            dbBinStr = IOUtils.toByteArray(is);
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    public String evaluate(Long s) {
        return evaluate(Util.long2ip(s), "region");
    }

    public String evaluate(Long s, String level) {
        return evaluate(Util.long2ip(s), level);
    }

    public String evaluate(String s) {
        return evaluate(s, "region");
    }

    public String evaluate(String s, String level) {
        if (!Util.isIpAddress(s)) {
            return "invalid ip address";
        }

        level = level.toLowerCase();
        String region = "region not Found";

        try {
            DbConfig config = new DbConfig();
            DbSearcher searcher = new DbSearcher(config, dbBinStr);

            // works only for "memorySearch" regardless of DbSearcher.MEMORY_ALGORITYM
            Method method = searcher.getClass().getMethod("memorySearch", String.class);

            DataBlock dataBlock = (DataBlock) method.invoke(searcher, s);

            if (level.equals("city_id")) {
                region = "" + dataBlock.getCityId();
            } else {
                region = dataBlock.getRegion();

                if (level.equals("region")) {
                    return region;
                }

                String[] regions = region.split("\\|");

                if (level.equals("country")) {
                    region = regions[0];
                } else if (level.equals("area")) {
                    region = regions[1];
                } else if (level.equals("province")) {
                    region = regions[2];
                } else if (level.equals("city")) {
                    region = regions[3];
                } else if (level.equals("isp")) {
                    region = regions[4];
                }
            }

        } catch (DbMakerConfigException e) {
            e.printStackTrace();
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }

        return region;
    }
}
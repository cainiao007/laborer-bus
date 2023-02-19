package com.laborer.bus.common.utils;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.RandomUtil;
import com.laborer.bus.common.constant.Constants;
import com.laborer.bus.common.constant.UploadPathEnum;
import com.laborer.bus.common.dto.UploadFileInfo;
import com.laborer.bus.common.exception.BusinessException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

/**
 * 文件上传工具
 * @author zhao zhenqiang
 */
public class FileUploadKit {

    private final static Logger LOGGER = LoggerFactory.getLogger(FileUploadKit.class);

    public static UploadFileInfo upload(MultipartFile multipartFile, UploadPathEnum pathEnum) {
        String basePath = System.getProperty("user.dir") + File.separator + Constants.BASE_USER_FILE_PATH;
        String filename = multipartFile.getOriginalFilename();
        String path = pathEnum.getPath() + "/" + DateUtil.format(DateUtil.date(), "yyyyMMdd");
        String filePath = basePath + "/" + path + "/" + filename;
        LOGGER.debug("upload filename:{}", filename);
        LOGGER.debug("upload filePath:{}", filePath);
        File file = new File(filePath);
        try {
            File parentFile = file.getParentFile();
            if (parentFile != null && !parentFile.exists()) {
                if (parentFile.mkdirs()) {
                    LOGGER.debug("created path:{}", parentFile.getAbsolutePath());
                }
            }
            if (file.exists()) {
                assert filename != null;
                int index = filename.lastIndexOf(".");
                filename = filename.substring(0, index) + "_" + RandomUtil.randomNumbers(5) + filename.substring(index);
                file = new File(basePath + "/" + path + "/" + filename);
            }
            if (file.createNewFile()) {
                multipartFile.transferTo(file);
            } else {
                throw new BusinessException("文件上传失败");
            }
        } catch (IOException e) {
            throw new BusinessException("文件上传失败：" + e.getMessage() + filePath);
        }

        return new UploadFileInfo(filename, path + "/" + filename, filePath.replaceAll("\\\\", "\\/"));
    }

}

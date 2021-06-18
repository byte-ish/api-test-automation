package com.learn.karate;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

@KarateOptions(tags = {"article"})
class ConduitTest {

   /* @Karate.Test
    Karate testAll() {
        return Karate.run().relativeTo(getClass());

    }*/
    @Test
    void testParallel() {
        Results results = Runner.parallel(getClass(),1);
        generateReport(results.getReportDir());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
        List<String> jsonPaths = new ArrayList(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "Conduit App");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
/*
    @Karate.Test
    Karate testTags() {
        return Karate.run().tags("@debugs").relativeTo(getClass());
    }*/
}

package com.stm.karate.mock;

import com.intuit.karate.core.MockServer;
import com.intuit.karate.junit5.Karate;
import com.intuit.karate.resource.ResourceUtils;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;

import java.io.File;

/**
 * This runner
 */
public class DemoMockTestRunner {

    private static MockServer mockServer;

    @BeforeAll
    static void startMockServer() {

        final File mockFile = ResourceUtils.getFileRelativeTo(DemoMockTestRunner.class, "demo-mock.feature");
        mockServer = MockServer.feature(mockFile).build();

        // 'classpath:' prefix  is supported
        // Relative resource resolution isn't
        // mockServer = MockServer.feature("classpath:com/stm/karate/mock/").build();
    }

    @AfterAll
    static void stopMockServer() {

        if (mockServer != null) {
            mockServer.stop();
        }
    }

    @Karate.Test
    Karate testDemoMockServer() {

        final Karate runner = Karate.run("test-demo-mock");
        runner.builder().systemProperty("mock_server_port", String.valueOf(mockServer.getPort()));
        return runner.relativeTo(getClass());
    }
}

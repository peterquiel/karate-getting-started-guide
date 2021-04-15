package com.stm.karate.mock;

import com.intuit.karate.core.MockServer;
import com.intuit.karate.junit5.Karate;
import com.intuit.karate.resource.ResourceUtils;
import org.junit.Rule;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.extension.RegisterExtension;

import java.io.File;

/**
 * This is a JUnit runner for the `demo-mock-test.feature`.
 *
 * It starts a Karate Mock `demo-mock.feature` and runs the
 * `demo-mock-test.feature`.
 *
 */
public class DemoMockTestRunner  {

    @RegisterExtension
    static KarateMockServerExtension mockServerRule = KarateMockServerExtension
        .create(DemoMockTestRunner.class, "demo-mock.feature");

    @Karate.Test
    Karate testDemoMockServer() {

        final Karate runner = Karate.run("demo-mock-test");
        runner.builder()
            .systemProperty("mock_server_port", String.valueOf(mockServerRule.getPort()))
            .relativeTo(getClass());
        return runner;
    }
}

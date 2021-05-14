package com.stm.karate.mock;

import com.intuit.karate.junit5.Karate;
import com.stm.karate.mock.util.KarateMockServerExtension;
import org.junit.jupiter.api.extension.RegisterExtension;

/**
 * This is a JUnit runner for the `demo-mock-test.feature`.
 *
 * It starts a Karate Mock `demo-mock.feature` using a junit5 extension 
 * and runs the `demo-mock-test.feature`.
 */
public class DemoMockTestRunner {

    @RegisterExtension
    static KarateMockServerExtension mockServerRule = KarateMockServerExtension
        .create(DemoMockTestRunner.class, "demo-mock.feature");

    @Karate.Test
    Karate testDemoMockServer() {

        return Karate.run("demo-mock-test")
            .systemProperty("mock_server_port", String.valueOf(mockServerRule.getPort()))
            .relativeTo(getClass());
    }
}
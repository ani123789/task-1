package test

import (
    "testing"

    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

func TestCodePipeline(t *testing.T) {
    terraformOptions := &terraform.Options{
        TerraformDir: "../", // points to your main Terraform project
    }

    terraform.InitAndApply(t, terraformOptions)
    defer terraform.Destroy(t, terraformOptions)

    pipelineName := terraform.Output(t, terraformOptions, "pipeline_name")
    assert.NotEmpty(t, pipelineName)
}

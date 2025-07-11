package test

import (
    "os"
    "testing"

    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

func TestTerraformPipeline(t *testing.T) {
    terraformOptions := &terraform.Options{
        TerraformDir: "../",
    }

    // Initialize and apply Terraform
    terraform.InitAndApply(t, terraformOptions)

    // ❗️Skip destroy if SKIP_DESTROY is set
    if os.Getenv("SKIP_DESTROY") != "true" {
        defer terraform.Destroy(t, terraformOptions)
    }

    // Your assertions go here
    bucketName := terraform.Output(t, terraformOptions, "artifact_bucket_name")
    assert.Contains(t, bucketName, "codepipeline-artifact")
}

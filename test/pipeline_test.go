package test

import (
  "testing"
  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/assert"
)

func TestTerraformPipeline(t *testing.T) {
  terraformOptions := &terraform.Options{
    TerraformDir: "..", // root where your Terraform code is
  }

  // defer terraform.Destroy(t, terraformOptions)

  terraform.InitAndApply(t, terraformOptions)

  output := terraform.Output(t, terraformOptions, "pipeline_name")
  assert.Contains(t, output, "MyCodePipeline")
}

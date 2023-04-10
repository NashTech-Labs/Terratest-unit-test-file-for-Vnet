package test

import (
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/azure"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestGetVirtualNetwork(t *testing.T) {
	t.Parallel()
	subscriptionID := ""
	uniquePostfix := random.UniqueId()
	// retryable errors in terraform testing.
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"postfix": strings.ToLower(uniquePostfix),
		},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	resourceGroupName := terraform.Output(t, terraformOptions, "resource_group")
	VirtualNetwork := terraform.Output(t, terraformOptions, "vnet_name")
	subnet := terraform.Output(t, terraformOptions, "new-subnet_name")

	t.Run("TestVirtualNetworkExistOrNot", func(t *testing.T) {
		VirtualNetworkExists := azure.VirtualNetworkExists(t, VirtualNetwork, resourceGroupName, subscriptionID)
		assert.True(t, VirtualNetworkExists, "virtual network does not exist")
	})

	//azure.WaitUntilServiceAvailable(t, options, "VirtualNetwork", 10, 20*time.Second)

	t.Run("TestSubnetMatchOrNot", func(t *testing.T) {
		SubnetExists := azure.SubnetExists(t, subnet, VirtualNetwork, resourceGroupName, subscriptionID)
		assert.True(t, SubnetExists, "subnet does not exist")
	})

}

from tests.constants import (
    ADMIN,
)
from starkware.cairo.common.cairo_builtins import HashBuiltin

struct DeployedContracts:
    member erc20_address : felt
    member main_address : felt
end

namespace test_integration:
    func deploy_contracts{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}() -> (
        deployed_contracts : DeployedContracts
    ):
        alloc_locals

        local erc20_address : felt
        local main_address : felt

        %{
            ids.erc20_address = deploy_contract(
            "./contracts/ERC20.cairo",
            [0x1, 0x1, 0x1, 1000000000, 0, ids.ADMIN]).contract_address
        %}

        %{
            ids.main_address = deploy_contract(
            "./contracts/main.cairo",
            []).contract_address
        %}

        let deployed_contracts = DeployedContracts(
            erc20_address=erc20_address,
            main_address=main_address
        )
        return (deployed_contracts)
    end

    func get_deployed_contracts_from_context() -> (deployed_contracts : DeployedContracts):
        tempvar erc20_address
        tempvar main_address

        %{ ids.erc20_address = context.erc20_address %}
        %{ ids.main_address = context.main_address %}

        let deployed_contracts = DeployedContracts(
            erc20_address=erc20_address,
            main_address=main_address
        )
        return (deployed_contracts)
    end
end
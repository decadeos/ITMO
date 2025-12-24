import torch

import linear_custom
import linear_torch

   
def test_linear_layer_function_forward_backward_matches_torch_linear():
    torch.manual_seed(0)
    batch, in_features, out_features = 4, 6, 3
    x = torch.randn(batch, in_features, requires_grad=True)
    w = torch.randn(out_features, in_features, requires_grad=True)
    b = torch.randn(out_features, requires_grad=True)

    custom_out = linear_custom.LinearLayerFunction.apply(x, w, b)
    torch_out = torch.nn.functional.linear(x, w, b)
    assert torch.allclose(custom_out, torch_out, atol=1e-6)

    custom_out.sum().backward()
    custom_grads = (x.grad.clone(), w.grad.clone(), b.grad.clone())

    x2 = x.detach().clone().requires_grad_(True)
    w2 = w.detach().clone().requires_grad_(True)
    b2 = b.detach().clone().requires_grad_(True)
    torch.nn.functional.linear(x2, w2, b2).sum().backward()
    torch_grads = (x2.grad, w2.grad, b2.grad)

    for got, expected in zip(custom_grads, torch_grads):
        assert torch.allclose(got, expected, atol=1e-6)


def test_linear_layer_module_behaves_like_function_without_torch_linear_inside():
    torch.manual_seed(0)
    module = linear_custom.LinearLayerModule(5, 4, bias=True)
    torch_linear_found = any(
        isinstance(m, torch.nn.Linear)
        for m in module.modules()
        if m is not module
    )
    assert not torch_linear_found, "LinearLayerModule should avoid torch.nn.Linear"

    x = torch.randn(7, 5, requires_grad=True)
    out = module(x)
    assert out.shape == (7, 4)
    ref = torch.nn.functional.linear(x, module.weight, module.bias)
    assert torch.allclose(out, ref, atol=1e-6)

    out.pow(2).mean().backward()
    assert module.weight.grad is not None
    if module.bias is not None:
        assert module.bias.grad is not None


def test_custom_mlp_uses_custom_layers_and_supports_backward():
    torch.manual_seed(0)
    model = linear_custom.CustomMLP(input_dim=4, hidden_dim=8, output_dim=2)
    custom_layers = [m for m in model.modules() if isinstance(m, linear_custom.LinearLayerModule)]
    assert len(custom_layers) >= 2, "CustomMLP should stack multiple LinearLayerModule layers"
    torch_layers = [m for m in model.modules() if isinstance(m, torch.nn.Linear)]
    assert len(torch_layers) == 0, "CustomMLP should rely on custom linear layers only"

    x = torch.randn(3, 4, requires_grad=True)
    out = model(x)
    assert out.shape == (3, 2)
    loss = out.sum()
    loss.backward()
    grads = [p.grad for p in model.parameters() if p.requires_grad]
    assert grads and all(g is not None for g in grads)


def test_torch_mlp_forward_and_structure():
    torch.manual_seed(0)
    model = linear_torch.TorchMLP(input_dim=4, hidden_dim=6, output_dim=3)
    linear_layers = [m for m in model.modules() if isinstance(m, torch.nn.Linear)]
    assert len(linear_layers) >= 2, "TorchMLP should contain at least two linear layers"

    x = torch.randn(5, 4, requires_grad=True)
    out = model(x)
    assert out.shape == (5, 3)
    out.mean().backward()
    grads = [p.grad for p in model.parameters() if p.requires_grad]
    assert grads and all(g is not None for g in grads)


def test_classification_loss_matches_cross_entropy():
    torch.manual_seed(0)
    criterion = linear_torch.ClassificationLoss()
    logits = torch.randn(4, 5, requires_grad=True)
    targets = torch.tensor([0, 2, 4, 1])

    custom_loss = criterion(logits, targets)
    assert custom_loss.shape == torch.Size([]), "Loss should be a scalar tensor"

    custom_loss.backward()
    assert logits.grad is not None
    assert logits.grad.shape == logits.shape




import torch
import torch.nn as nn
import torch.nn.functional as F  

class LinearLayerFunction(torch.autograd.Function):
    @staticmethod
    def forward(ctx, input, weight, bias):
        """y = x @ weight.t() + bias"""
        ctx.save_for_backward(input, weight, bias)
        return input @ weight.t() + bias 

    @staticmethod
    def backward(ctx, grad_output):
        input, weight, _ = ctx.saved_tensors
        return (
            grad_output @ weight,     
            grad_output.t() @ input,  
            grad_output.sum(dim=0) 
        )

class LinearLayerModule(nn.Module):
    def __init__(self, in_features, out_features, bias=True):
        super().__init__()
        self.weight = nn.Parameter(torch.Tensor(out_features, in_features))
        self.bias = nn.Parameter(torch.Tensor(out_features)) if bias else None
        self.reset_parameters()

    def reset_parameters(self):
        nn.init.xavier_uniform_(self.weight)
        if self.bias is not None:
            nn.init.zeros_(self.bias)

    def forward(self, x):
        bias = self.bias if self.bias is not None else \
               torch.zeros(self.weight.size(0), device=x.device, dtype=x.dtype)
        return LinearLayerFunction.apply(x, self.weight, bias)

class CustomMLP(nn.Module):
    def __init__(self, input_dim, hidden_dim, output_dim):
        super().__init__()
        self.net = nn.Sequential(
            LinearLayerModule(input_dim, hidden_dim),
            nn.ReLU(),
            LinearLayerModule(hidden_dim, output_dim)
        )

    def forward(self, x):
        return self.net(x)
    

    
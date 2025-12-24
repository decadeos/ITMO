import torch 


class TorchMLP(torch.nn.Module):
    def __init__(
            self, 
            input_dim: int,
            hidden_dim: int,
            output_dim: int,
    ):
        super().__init__()
        
        self.layer1 = torch.nn.Linear(input_dim, hidden_dim)
        self.layer2 = torch.nn.Linear(hidden_dim, output_dim)
        self.relu = torch.nn.ReLU()
    
    def forward(self, x: torch.Tensor) -> torch.Tensor:
        x = self.layer1(x)
        x = self.relu(x)
        x = self.layer2(x)
        return x


class ClassificationLoss(torch.nn.Module):
    def __init__(self):
        super().__init__()
        
    def forward(self, predictions: torch.Tensor, targets: torch.Tensor) -> torch.Tensor:
        return torch.nn.functional.cross_entropy(predictions, targets)
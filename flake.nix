{
  description = "Flake templates for common projects";

  outputs = { self }: {
    templates = {
      python-uv = {
        path = ./templates/python-uv;
        description = "Python template using uv, just, and pre-commit.";
      };
      bun-node = {
        path = ./templates/bun-node;
        description = "Bun + Node using biome, just, and pre-commit.";
      };
    };
  };
}

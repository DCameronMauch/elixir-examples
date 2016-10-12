defmodule RecursiveModel.RecursionTransversal do
  defmacro __using__(opts) do
    quote bind_quoted: binding() do
      @repo Keyword.fetch!(opts, :repo)

      def ancestors(model) do
        ancestors_and_self(model) |> except(model)
      end

      def ancestors_and_self(model) do
        ancestors_and_self(model, [])
      end

      defp ancestors_and_self(%{parent_id: nil} = model, list) do
        [model | list]
      end

      defp ancestors_and_self(model, list) do
        ancestors_and_self(parent(model), [model | list])
      end

      def branch?(model) do
        !leaf?(model)
      end

      def child?(model) do
        !root?(model)
      end

      def children(model) do
        @repo.preload(model, :children).children
      end

      def descendants(model) do
        descendants([model], [])
      end

      defp descendants([], list) do
        list
      end

      defp descendants(models, list) do
        children = Enum.flat_map(models, &children/1)
        descendants(children, children ++ list)
      end

      def depth(model) do
        depth(model, 0)
      end

      defp depth(%{parent_id: nil}, depth) do
        depth
      end

      defp depth(model, depth) do
        depth(parent(model), depth + 1)
      end

      defp except(models, model) do
        Enum.reject(models, &(&1.id == model.id))
      end

      def leaf?(model) do
        children(model) == []
      end

      def leaves(model) do
        leaves([model], [])
      end

      defp leaves([], list) do
        list
      end

      defp leaves(models, list) do
        children = Enum.flat_map(models, &children/1)
        leaves = Enum.filter(models, &leaf?/1)
        leaves(children, leaves ++ list)
      end

      def parent(model) do
        @repo.preload(model, :parent).parent
      end

      def root(%{parent_id: nil} = model) do
        model
      end

      def root(model) do
        root(parent(model))
      end

      def root?(model) do
        model.parent_id == nil
      end

      def siblings(model) do
        siblings_and_self(model) |> except(model)
      end

      def siblings_and_self(%{parent_id: nil} = model) do
        [model]
      end

      def siblings_and_self(model) do
        model |> parent |> children
      end
    end
  end
end

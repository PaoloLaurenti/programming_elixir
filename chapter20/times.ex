defmodule Times do
  defmacro times_n(n) do
    quote do
      def unquote(:"times_#{n}")(value) do
         value * unquote(n)
      end
    end
  end
end

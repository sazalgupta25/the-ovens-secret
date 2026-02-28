import { ButtonHTMLAttributes } from "react";

interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: "primary" | "secondary" | "danger" | "ghost";
  size?: "sm" | "md" | "lg";
  isLoading?: boolean;
  children: React.ReactNode;
}

export function Button({
  variant = "primary",
  size = "md",
  isLoading = false,
  disabled = false,
  className = "",
  children,
  ...props
}: ButtonProps) {
  const baseStyles =
    "font-semibold rounded-lg transition-all duration-200 disabled:cursor-not-allowed disabled:opacity-60";

  const variantStyles = {
    primary: "bg-[#c0392b] text-white hover:bg-[#a93226]",
    secondary: "bg-[#fdf6ee] text-[#7b3f2e] border border-[#e8c9a0] hover:bg-[#faebd7]",
    danger: "bg-red-600 text-white hover:bg-red-700",
    ghost: "text-[#7b3f2e] hover:bg-[#fdf0e0]",
  };

  const sizeStyles = {
    sm: "px-3 py-1.5 text-sm",
    md: "px-4 py-2 text-base",
    lg: "px-8 py-3 text-lg",
  };

  return (
    <button
      disabled={disabled || isLoading}
      className={`${baseStyles} ${variantStyles[variant]} ${sizeStyles[size]} ${className}`}
      {...props}
    >
      {isLoading ? "Loading..." : children}
    </button>
  );
}

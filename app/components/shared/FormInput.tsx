import { InputHTMLAttributes } from "react";

interface FormInputProps extends InputHTMLAttributes<HTMLInputElement> {
  label?: string;
  error?: string;
  helperText?: string;
  fullWidth?: boolean;
}

export function FormInput({
  label,
  error,
  helperText,
  fullWidth = true,
  className = "",
  disabled = false,
  ...props
}: FormInputProps) {
  return (
    <div className={fullWidth ? "w-full" : ""}>
      {label && (
        <label className="block text-sm font-semibold text-gray-700 mb-1">
          {label}
          {props.required && <span className="text-red-600 ml-1">*</span>}
        </label>
      )}

      <input
        disabled={disabled}
        className={`w-full px-4 py-2 border rounded-lg focus:outline-none transition ${
          error
            ? "border-red-500 focus:border-red-600 bg-red-50"
            : "border-gray-300 focus:border-[#c0392b] disabled:bg-gray-100 disabled:cursor-not-allowed"
        } ${className}`}
        {...props}
      />

      {error && <p className="text-red-600 text-sm mt-1">{error}</p>}
      {helperText && !error && <p className="text-gray-500 text-sm mt-1">{helperText}</p>}
    </div>
  );
}

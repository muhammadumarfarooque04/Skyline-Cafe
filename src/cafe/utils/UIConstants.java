package cafe.utils;

import java.awt.*;
import javax.swing.*;
import javax.swing.border.EmptyBorder;
import javax.swing.table.*;


/**
 * UIConstants - Centralized styling constants for the Cafe Management System.
 * Ensures a consistent, attractive UI across all panels.
 */
public class UIConstants {

    // Color Palette - Neon Skyline Theme (Matches logo.jpeg)
    public static final Color PRIMARY      = new Color(0x00E5FF);   // Electric Cyan
    public static final Color PRIMARY_DARK = new Color(0x00B8D4);   // Deep Cyan
    public static final Color ACCENT       = new Color(0x00E5FF);   // Neon Blue
    public static final Color SUCCESS      = new Color(0x00E676);   // Neon Green
    public static final Color DANGER       = new Color(0xFF1744);   // Neon Red
    public static final Color WARNING      = new Color(0xFFEA00);   // Neon Yellow
    public static final Color BG_LIGHT     = new Color(0x0A0E14);   // Deep Space Black
    public static final Color BG_PANEL     = new Color(0x10161D);   // Cyber Grey
    public static final Color TEXT_DARK    = new Color(0xE0F7FA);   // Ice White
    public static final Color TEXT_GRAY    = new Color(0x80DEEA);   // Cyan Gray
    public static final Color SIDEBAR_BG   = new Color(0x05080A);   // Void Black
    public static final Color TABLE_HEADER = new Color(0x00B8D4);
    public static final Color TABLE_ROW1   = new Color(0x10161D);
    public static final Color TABLE_ROW2   = new Color(0x151C24);
    public static final Color BORDER_COLOR = new Color((60 << 24) | 0x00E5FF, true); // Transparent Cyan Border

    // Gradient Colors - Cyber Glow
    public static final Color GRAD_TOP    = new Color(0x0D47A1);   // Deep Navy
    public static final Color GRAD_BOTTOM = new Color(0x010203);   // Pitch Black
    
    // Button gradient colors (Neon Glow style)
    public static final Color BTN_PRIMARY_TOP    = new Color(0x00E5FF);
    public static final Color BTN_PRIMARY_BOT    = new Color(0x0097A7);
    public static final Color BTN_SUCCESS_TOP    = new Color(0x00C853);
    public static final Color BTN_SUCCESS_BOT    = new Color(0x1B5E20);
    public static final Color BTN_DANGER_TOP     = new Color(0xFF1744);
    public static final Color BTN_DANGER_BOT     = new Color(0xB71C1C);
    public static final Color BTN_GRAY_TOP       = new Color(0x455A64);
    public static final Color BTN_GRAY_BOT       = new Color(0x263238);
    public static final Color BTN_ACCENT_TOP     = new Color(0x00B8D4);
    public static final Color BTN_ACCENT_BOT     = new Color(0x006064);

    // Fonts
    public static final Font FONT_TITLE   = new Font("Segoe UI", Font.BOLD, 22);
    public static final Font FONT_HEADING = new Font("Segoe UI", Font.BOLD, 16);
    public static final Font FONT_REGULAR = new Font("Segoe UI", Font.PLAIN, 14);
    public static final Font FONT_SMALL   = new Font("Segoe UI", Font.PLAIN, 12);
    public static final Font FONT_BOLD    = new Font("Segoe UI", Font.BOLD, 14);

    // Sizes
    public static final int SIDEBAR_WIDTH  = 220;
    public static final int BUTTON_HEIGHT  = 40;
    public static final Dimension FIELD_SIZE = new Dimension(250, 36);

    private UIConstants() {}

    /**
     * Creates a JLabel that displays a live clock (HH:mm:ss — dd MMM yyyy),
     * updated every second via a Swing Timer.
     */
    public static JLabel createLiveClock() {
        JLabel clock = new JLabel();
        clock.setFont(new Font("Segoe UI", Font.BOLD, 13));
        clock.setForeground(TEXT_GRAY);

        // Helper to update text
        Runnable tick = () -> clock.setText(
                java.time.LocalDateTime.now()
                        .format(java.time.format.DateTimeFormatter.ofPattern("hh:mm:ss a  •  dd MMM yyyy")));
        tick.run(); // set initial value

        Timer timer = new Timer(1000, e -> tick.run());
        timer.setRepeats(true);
        timer.start();

        return clock;
    }

    /**
     * Applies a gradient-painted header renderer to every column of the given table.
     * Uses the same GRAD_TOP → GRAD_BOTTOM palette as the sidebar.
     */
    public static void applyGradientHeader(JTable table) {
        JTableHeader header = table.getTableHeader();
        header.setDefaultRenderer(new DefaultTableCellRenderer() {
            @Override
            public Component getTableCellRendererComponent(
                    JTable t, Object value, boolean isSelected,
                    boolean hasFocus, int row, int column) {

                // Use a custom panel as the cell
                JPanel cell = new JPanel(new BorderLayout()) {
                    @Override
                    protected void paintComponent(Graphics g) {
                        Graphics2D g2 = (Graphics2D) g.create();
                        g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
                                RenderingHints.VALUE_ANTIALIAS_ON);
                        GradientPaint gp = new GradientPaint(
                                0, 0, GRAD_TOP,
                                0, getHeight(), GRAD_BOTTOM);
                        g2.setPaint(gp);
                        g2.fillRect(0, 0, getWidth(), getHeight());
                        // Right-side separator line
                        g2.setColor(new Color(255, 255, 255, 30));
                        g2.drawLine(getWidth() - 1, 4, getWidth() - 1, getHeight() - 4);
                        g2.dispose();
                    }
                };
                cell.setOpaque(false);
                cell.setBorder(new EmptyBorder(0, 10, 0, 10));

                JLabel lbl = new JLabel(value == null ? "" : value.toString());
                lbl.setFont(FONT_BOLD);
                lbl.setForeground(Color.WHITE);
                cell.add(lbl, BorderLayout.CENTER);
                return cell;
            }
        });
        header.setPreferredSize(new Dimension(0, 32));
        header.setOpaque(false);
        header.setBorder(null);
    }
}
